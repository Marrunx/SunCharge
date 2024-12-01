//D2 - SDA
//D5 - SCK
//D7 - MOSI
//D6 - MISO
//D1 - RST
//3.3V - 3.3V
//GND - GND
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h> // Add this library for RFID

#define RST_PIN D1       // Reset pin for MFRC522
#define SS_PIN D2        // Slave select pin for MFRC522
#define relayPin D4      // Relay connected to D8

// WiFi details 
const char* ssid = "Note10Pro";              // Your WiFi SSID
const char* password = "Capustone";       // Your WiFi password

// Server details
const char* serverUrl = "http://192.168.80.63/SunChargeV2/function/scan_uid_locker-1.php"; // Your PHP script URL

bool lockerIsLocked = true; // Track if the locker is locked

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create an MFRC522 instance
WiFiClient wifiClient; // Create a WiFiClient instance for HTTP requests

void setup() {
  Serial.begin(115200);
  SPI.begin();          // Initialize SPI bus
  mfrc522.PCD_Init();   // Initialize MFRC522

  pinMode(relayPin, OUTPUT);

  // Connect to WiFi
  Serial.println("Connecting to WiFi...");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi.");
  digitalWrite(relayPin, HIGH);
}

void loop() {
  // Check if a new card is present
  if (!mfrc522.PICC_IsNewCardPresent()) {
    return; // No new card present
  }
  if (!mfrc522.PICC_ReadCardSerial()) {
    return; // Unable to read card
  }

  // Prepare UID string
  String uid = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    uid += String(mfrc522.uid.uidByte[i], HEX);
  }
  uid.toUpperCase(); // Convert UID to uppercase for consistency

  Serial.println("UID detected: " + uid);

  sendUIDToServer(uid); // Send UID to server for verification
  mfrc522.PICC_HaltA(); // Halt the PICC (card)
}

void sendUIDToServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;

    // Specify request destination
    http.begin(wifiClient, serverUrl); // Updated to use WiFiClient
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // Prepare data
    String httpRequestData = "card_uid=" + uid;

    // Send the POST request
    int httpResponseCode = http.POST(httpRequestData);

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("HTTP Response code: " + String(httpResponseCode));
      Serial.println("Server Response: " + response);

      // Check if access is granted and assigned to the correct locker number (for charger1, check if "locker_number" is "charger1")
      if (response.indexOf("\"status\":\"success\"") != -1 && response.indexOf("\"locker_number\":\"charger1\"") != -1) {
        Serial.println("Access granted for charger1");

        // Proceed to toggle lock
        toggleLock();
      } else if (response.indexOf("\"status\":\"in_use\"") != -1) {
        Serial.println("Access Denied: Card is already assigned to another charger.");
      } else {
        Serial.println("Access Denied: UID " + uid + " not recognized or not assigned to charger1.");
      }
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free HTTP resources
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
    delay(5000);

    // Lock the locker again
    Serial.println("Locker is now Locked again.");
    lockerIsLocked = true;
    digitalWrite(relayPin, HIGH); // Lock the locker
  }
}
