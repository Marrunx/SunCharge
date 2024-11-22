// Pinout Configuration:
// RST  - G22
// SDA  - G21
// MOSI - G23
// MISO - G19
// IRQ  - --
// GND  - GND
// 3.3V - 3.3V
// SCK  - G18

#include <SPI.h>
#include <MFRC522.h>
#include <WiFi.h>
#include <HTTPClient.h>

#define SS_PIN 21       // Pin for SDA G21
#define RST_PIN 22      // Pin for RST
int relayPin = 17;      // Relay Pin G14

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance

const char* ssid = "Marron";        // Your WiFi SSID
const char* password = "543210123"; // Your WiFi password
const char* serverURL = "http://192.168.0.117/SunChargeV2/function/scan_uid_locker-1.php"; // URL to PHP script

bool lockerIsLocked = true; // Track if the locker is locked

void setup() {
    Serial.begin(115200);
    SPI.begin();          // Initialize SPI bus
    mfrc522.PCD_Init();   // Initialize MFRC522
    pinMode(relayPin, OUTPUT);

    // Ensure the relay starts in a locked state (relay off)
    digitalWrite(relayPin, HIGH);

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

    sendUIDToServer(uid); // Send UID to server for verification
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
                toggleLock();
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

void toggleLock() {
    if (lockerIsLocked) {
        // Unlock the locker if it is currently locked
        Serial.println("Locker is now Unlocked.");
        lockerIsLocked = false;
        digitalWrite(relayPin, LOW); // Activate the relay (unlock the locker)

        // Wait for 5 seconds before locking the locker again
        delay(5000); // Wait 5 seconds

        // Lock the locker again after the delay
        Serial.println("Locker is now Locked again.");
        lockerIsLocked = true;
        digitalWrite(relayPin, HIGH); // Lock the locker
    }
    delay(500);
}
