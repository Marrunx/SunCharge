#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h> // RFID library
#include <ArduinoJson.h>


#define RST_PIN D1       // Reset pin for MFRC522
#define SS_PIN D2        // Slave select pin for MFRC522
#define relayPin D4      // Relay connected to D4
#define buzzerPin D3     // Buzzer connected to D3

// WiFi details
const char* ssid = "PPLLLPP";              // Your WiFi SSID
const char* password = "1234556677";       // Your WiFi password

// Server details
const char* serverUrlScan = "http://192.168.80.63/SunChargeV2/function/scan_uid_locker-1.php"; 
const char* serverUrlLogAccess = "http://192.168.80.63/SunChargeV2/function/log_access.php";
const char* serverUrlGetBalance = "http://192.168.80.63/SunChargeV2/function/get_balance.php"; // URL to get the balance from tbl_cardext
const char* serverUrlResetBalance = "http://192.168.80.63/SunChargeV2/function/reset_balance.php"; // URL to reset the balance
bool lockerIsLocked = true; // Tracks if the locker is locked

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create an MFRC522 instance
WiFiClient wifiClient;           // Create a WiFiClient instance for HTTP requests

void setup() {
  Serial.begin(115200);
  SPI.begin(); // Initialize SPI bus
  mfrc522.PCD_Init(); // Initialize MFRC522

  pinMode(relayPin, OUTPUT);
  pinMode(buzzerPin, OUTPUT);

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

  // Send UID to the server for verification and to get the balance
  sendUIDToServer(uid);

  mfrc522.PICC_HaltA(); // Halt the PICC (card)
}

void sendUIDToServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(wifiClient, serverUrlScan);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // Prepare data
    String httpRequestData = "card_uid=" + uid;

    // Send POST request
    int httpResponseCode = http.POST(httpRequestData);

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("HTTP Response code: " + String(httpResponseCode));
      Serial.println("Server Response: " + response);

      // Parse response
      if (response.indexOf("\"status\":\"success\"") != -1) {
        Serial.println("Access Granted.");
        logAccessToServer(uid, "Access Granted");

        // Check for balance
        int balance = getBalanceFromServer(uid);
        if (balance > 0) {
          Serial.println("Balance available. Unlocking locker...");
          toggleLock(); // Unlock locker if balance is available
          resetBalance();
        } else {
          Serial.println("No balance available. Access Denied.");
          logAccessToServer(uid, "No Balance - Access Denied");
          digitalWrite(buzzerPin, HIGH);
          delay(500);
          digitalWrite(buzzerPin, LOW);
        }
      } else if (response.indexOf("\"status\":\"access_denied\"") != -1) {
        Serial.println("Access Denied.");
        logAccessToServer(uid, "Access Denied");
        digitalWrite(buzzerPin, HIGH);
        delay(500);
        digitalWrite(buzzerPin, LOW);
      }
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free HTTP resources
  } else {
    
    Serial.println("WiFi Disconnected");
  }
}
int getBalanceFromServer(String uid) {
  int balance = 0;
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(wifiClient, serverUrlGetBalance); // The PHP script that gets balance and updates tbl_card
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // Send the UID to the PHP script
    String httpRequestData = "card_uid=" + uid;

    // Send POST request
    int httpResponseCode = http.POST(httpRequestData);

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("Balance Fetch Response code: " + String(httpResponseCode));
      Serial.println("Server Response: " + response);

      // Parse the JSON response for balance
      DynamicJsonDocument doc(1024);
      deserializeJson(doc, response);

      // Check if the response contains status "success"
      String status = doc["status"].as<String>();
      if (status == "success") {
        balance = doc["balance"].as<int>(); // Get balance
        Serial.println("Balance retrieved: " + String(balance));
      } else {
        Serial.println("Error: " + doc["message"].as<String>());
      }
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free HTTP resources
  } else {
    Serial.println("WiFi Disconnected");
  }

  return balance; // Return the balance
}
void logAccessToServer(String uid, String description) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(wifiClient, serverUrlLogAccess);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // Prepare data
    String httpRequestData = "card_uid=" + uid + "&description=" + description;

    // Send POST request
    int httpResponseCode = http.POST(httpRequestData);

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("Log Access Response: " + response);
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free HTTP resources
  } else {
    Serial.println("WiFi Disconnected");
  }
} 
void resetBalance() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(wifiClient, serverUrlResetBalance); // URL to reset balance

    // Send POST request to reset balance
    int httpResponseCode = http.POST("");

    if (httpResponseCode > 0) {
      String response = http.getString(); // Get server response
      Serial.println("Balance Reset Response: " + response);
    } else {
      Serial.println("Error on sending reset balance POST: " + String(httpResponseCode));
    }

    http.end(); // Free HTTP resources
  } else {
    Serial.println("WiFi Disconnected");
  }
}

void toggleLock() {
  if (lockerIsLocked) {
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
    digitalWrite(relayPin, LOW); // Activate relay (unlock locker)

    delay(5000); // Keep unlocked for 5 seconds

    digitalWrite(buzzerPin, HIGH);
    delay(300);
    digitalWrite(buzzerPin, LOW);
    delay(300);
    digitalWrite(relayPin, HIGH); // Deactivate relay (lock locker)

    
    lockerIsLocked = true;
    Serial.println("Locker is now Locked.");
  } else {
    Serial.println("Locker is already unlocked.");
  }
}
