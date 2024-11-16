// Pin Definitions
// SDA - G21
// SCK - G18
// MOSI - G23
// MISO - G19
// GND - GND
// RST - G22
// 3.3V - 3.3V

#include <SPI.h>
#include <MFRC522.h>
#include <WiFi.h>
#include <HTTPClient.h>

#define SS_PIN 21         // Pin for SDA
#define RST_PIN 22        // Pin for RST
int relayPin = 13;       // Relay Pin

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance

const char* ssid = "Marron";           // Your WiFi SSID
const char* password = "543210123";    // Your WiFi password
const char* serverURL = "http://192.168.0.117/SunChargeV2/function/scan_uid.php"; // URL to PHP script

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

    // Check if access is granted for the same UID
    if (accessGranted && uid == lastGrantedUID) {
        toggleAccess();  // Toggle locker (lock/unlock) for the same UID
    } else if (!accessGranted) {
        sendUIDToServer(uid); // Only check UID with server if no access granted
    } else {
        Serial.println("Access Denied: Locker is in use by another UID.");
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
            Serial.println("Server Response: " + response); // Print server response

            // Check if response contains "status": "found"
            if (response.indexOf("\"status\":\"found\"") != -1) {
                grantAccess(uid); // Grant access if UID is found in the database
            } else {
                Serial.println("Access Denied: UID " + uid + " not recognized.");
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
    lastGrantedUID = uid; // Store the granted UID to track access
    lockerIsLocked = false; // Locker is unlocked
    Serial.println("Access Granted for UID " + uid + ": Locker unlocked.");
    digitalWrite(relayPin, HIGH);
}

void revokeAccess() {
    accessGranted = false;
    Serial.println("Access Revoked for UID " + lastGrantedUID + ": Locker locked due to timeout.");
    digitalWrite(relayPin, LOW);
    lockerIsLocked = true; // Locker is locked
    lastGrantedUID = "";  // Clear the last granted UID to allow new card scans
}

void toggleAccess() {
    if (!lockerIsLocked) {
        Serial.println("Locker is now Locked.");
        lockerIsLocked = true;
        digitalWrite(relayPin, LOW);
    } else {
        Serial.println("Locker is now Unlocked.");
        lockerIsLocked = false;
        digitalWrite(relayPin, HIGH);
    }
}
