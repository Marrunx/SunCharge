#include <SPI.h>
#include <MFRC522.h>
#include <WiFi.h>
#include <HTTPClient.h>

#define SS_PIN 21         // Pin for SDA
#define RST_PIN 22        // Pin for RST
int relayPin = 14;       // Relay Pin G14

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance

const char* ssid = "Marron";           // Your WiFi SSID
const char* password = "543210123";    // Your WiFi password
const char* serverURL = "http://192.168.0.117/SunChargeV2/function/scan_uid_locker-1.php"; // URL to PHP script

String lastGrantedUID = "";   // Store the UID that was last granted access
bool accessGranted = false;  // Track if access is currently granted
bool lockerIsLocked = true;  // Track if the locker is locked

void setup() {
    Serial.begin(115200);
    SPI.begin();          // Initialize SPI bus
    mfrc522.PCD_Init();   // Initialize MFRC522
    pinMode(relayPin, OUTPUT);

    // Connect to WiFi
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connecting to WiFi...");
    }
    Serial.println("Connected to WiFi");
}

void loop() {
    if (!mfrc522.PICC_IsNewCardPresent()) {
        return; // No new card present
    }
    if (!mfrc522.PICC_ReadCardSerial()) {
        return; // No card selected
    }

    // Prepare UID string
    String uid = "";
    for (byte i = 0; i < mfrc522.uid.size; i++) {
        uid += String(mfrc522.uid.uidByte[i], HEX);
    }

    // If access is granted for the same UID, toggle the lock (lock/unlock)
    if (accessGranted && uid == lastGrantedUID) {
        toggleLock();  // Toggle lock/unlock if the same card is scanned again
    } else {
        sendUIDToServer(uid); // Send UID to server for verification
    }

    mfrc522.PICC_HaltA(); // Halt the PICC (card)
}

void sendUIDToServer(String uid) {
    if (WiFi.status() == WL_CONNECTED) {
        HTTPClient http;

        // Specify request destination
        http.begin(serverURL);
        http.addHeader("Content-Type", "application/x-www-form-urlencoded");
        
        // Prepare data
        String httpRequestData = "card_uid=" + uid;
        
        // Send the POST request
        int httpResponseCode = http.POST(httpRequestData);
        
        if (httpResponseCode > 0) {
            String response = http.getString(); // Get server response
            Serial.println("HTTP Response code: " + String(httpResponseCode));
            Serial.println("Server Response: " + response);

            // Check if access is granted and assigned to charger1
            if (response.indexOf("\"status\":\"success\"") != -1 && response.indexOf("\"used_by\":\"charger1\"") != -1) {
                grantAccess(uid);
            } else if (response.indexOf("\"status\":\"in_use\"") != -1) {
                Serial.println("Access Denied: Card is already assigned to another charger.");
            } else {
                Serial.println("Access Denied: UID " + uid + " not recognized or not assigned to charger1.");
            }
        } else {
            Serial.print("Error on sending POST: ");
            Serial.println(httpResponseCode);
        }

        // Free HTTP resources
        http.end();
    } else {
        Serial.println("WiFi Disconnected");
    }
}

void grantAccess(String uid) {
    accessGranted = true;
    lastGrantedUID = uid; // Store the granted UID
    lockerIsLocked = false; // Locker is unlocked
    Serial.println("Access Granted for UID " + uid + ": Charger 1 activated.");
    digitalWrite(relayPin, HIGH); // Activate the relay (unlock the locker)
}

void revokeAccess() {
    accessGranted = false;
    Serial.println("Access Revoked for UID " + lastGrantedUID + ": Charger 1 deactivated.");
    digitalWrite(relayPin, LOW); // Deactivate the relay (lock the locker)
    lockerIsLocked = true; // Locker is locked
    lastGrantedUID = ""; // Clear the last granted UID
}

void toggleLock() {
    if (!lockerIsLocked) {
        // Lock the locker if it is currently unlocked
        Serial.println("Locker is now Locked.");
        lockerIsLocked = true;
        digitalWrite(relayPin, LOW); // Deactivate the relay (lock the locker)
    } else {
        // Unlock the locker if it is currently locked
        Serial.println("Locker is now Unlocked.");
        lockerIsLocked = false;
        digitalWrite(relayPin, HIGH); // Activate the relay (unlock the locker)
    }
}
