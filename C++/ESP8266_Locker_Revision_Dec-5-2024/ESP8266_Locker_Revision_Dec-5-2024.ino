// D2 - SDA
// D5 - SCK
// D7 - MOSI
// D6 - MISO
// D1 - RST
// 3.3V - 3.3V
// GND - GND
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h> // RFID library

#define RST_PIN D1       // Reset pin for MFRC522
#define SS_PIN D2        // Slave select pin for MFRC522
#define relayPin D4      // Relay connected to D8
#define buzzerPin D3 

// WiFi details 
const char* ssid = "OPPOA17";              // Your WiFi SSID
const char* password = "jjuralbal";       // Your WiFi password

// Server details
const char* serverUrlScan = "http://192.168.249.63/SunChargeV2/function/scan_uid_locker-1.php"; // PHP script for UID scanning
const char* serverUrlBalance = "http://192.168.249.63/SunChargeV2/function/get_balance.php"; // PHP script for balance retrieval
const char* serverUrlSendBalance = "http://192.168.249.63/SunChargeV2/function/send_balance.php"; // PHP script for sending the balance

bool lockerIsLocked = true; // Track if the locker is locked

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create an MFRC522 instance
WiFiClient wifiClient; // Create a WiFiClient instance for HTTP requests

void setup() {
  Serial.begin(115200);
  SPI.begin();          // Initialize SPI bus
  mfrc522.PCD_Init();   // Initialize MFRC522

  pinMode(relayPin, OUTPUT);
  pinMode(buzzerPin, OUTPUT); // Initialize the buzzer pin

  // Connect to WiFi
  Serial.println("Connecting to WiFi...");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi.");
  digitalWrite(relayPin, HIGH); // Ensure relay is off (locker locked)
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

  // First, send the UID to scan_uid_locker-1.php to verify if the UID is valid
  sendUIDToScanServer(uid);

  // Then, get the balance using the UID
  getBalanceFromServer(uid);

  mfrc522.PICC_HaltA(); // Halt the PICC (card)
}

void sendUIDToScanServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;

    // Specify request destination
    http.begin(wifiClient, serverUrlScan);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // Prepare data
    String httpRequestData = "card_uid=" + uid;

    // Send the POST request
    int httpResponseCode = http.POST(httpRequestData);

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("HTTP Response code: " + String(httpResponseCode));
      Serial.println("Server Response: " + response);

      // You can handle the response here, e.g., unlocking the locker based on the response
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free HTTP resources
  } else {
    Serial.println("WiFi Disconnected");
  }
}

void getBalanceFromServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;

    // Specify request destination
    http.begin(wifiClient, serverUrlBalance);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // Prepare data
    String httpRequestData = "card_uid=" + uid;

    // Send the POST request
    int httpResponseCode = http.POST(httpRequestData);

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("HTTP Response code: " + String(httpResponseCode));
      Serial.println("Balance Response: " + response);

      int rfid_balance = response.toInt(); // Convert the plain text response to an integer

      if (rfid_balance > 0) {
        Serial.println("RFID Balance: " + String(rfid_balance)); // Print the balance

        // Send the RFID balance to the coinslot_balance column
        sendBalanceToCoinslotServer(uid, rfid_balance);

        // Unlock the locker
        toggleLock();
      } else {
        Serial.println("Access Denied: UID not recognized or insufficient balance.");
        digitalWrite(buzzerPin, HIGH);
        delay(500);
        digitalWrite(buzzerPin, LOW);
        delay(500);

      }
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free HTTP resources
  } else {
    Serial.println("WiFi Disconnected");
  }
}

void sendBalanceToCoinslotServer(String uid, int rfid_balance) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;

    // Specify request destination
    http.begin(wifiClient, serverUrlSendBalance);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // Prepare data
    String httpRequestData = "card_uid=" + uid + "&rfid_balance=" + String(rfid_balance);

    // Send the POST request
    int httpResponseCode = http.POST(httpRequestData);

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("HTTP Response code: " + String(httpResponseCode));
      Serial.println("Server Response: " + response);
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

    digitalWrite(buzzerPin, HIGH);
    delay(100);
    digitalWrite(buzzerPin, LOW);
    delay(100);
    digitalWrite(buzzerPin, HIGH);
    delay(100);
    digitalWrite(buzzerPin, LOW);
    delay(100);

    digitalWrite(relayPin, LOW); // Activate the relay (unlock the locker)

    // Wait for 5 seconds before locking the locker again
    delay(5000);

    // Lock the locker again

    digitalWrite(buzzerPin, HIGH);
    delay(300);
    digitalWrite(buzzerPin, LOW);
    delay(300);
    Serial.println("Locker is now Locked.");
    lockerIsLocked = true;
    digitalWrite(relayPin, HIGH); // Deactivate the relay (lock the locker)

  } else {
    Serial.println("Locker is already unlocked. Please close the locker to lock it again.");
  }
} 