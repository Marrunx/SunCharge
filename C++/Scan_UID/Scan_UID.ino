#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN D2  // SDA pin of MFRC522
#define RST_PIN D1 // Reset pin of MFRC522

MFRC522 mfrc522(SS_PIN, RST_PIN);

const char* ssid = "PPLLLPP"; // Replace with your WiFi SSID
const char* password = "1234556677"; // Replace with your WiFi password
const char* serverUrl = "http://192.168.80.63/SunChargeV2/function/scanned_uid.php"; // Replace with your server's URLC:\xampp\htdocs\ComputerRental\Revised\function
                                                                                                // Check IPv4 in CMD using IPConfig
                                                                                                // C:\xampp\htdocs\SunChargeV2\function

WiFiClient client;

void setup() {
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init();

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");
}

void loop() {
  if (!mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial()) {
    return;
  }

  String uid = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    uid += String(mfrc522.uid.uidByte[i], HEX);
  }
  uid.toUpperCase();

  Serial.println("UID scanned: " + uid);

  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(client, serverUrl); // Updated to use WiFiClient
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    String postData = "uid=" + uid;
    int httpResponseCode = http.POST(postData);

    if (httpResponseCode > 0) {
      Serial.println("POST successful: " + String(httpResponseCode));
    } else {
      Serial.println("Error in POST: " + String(httpResponseCode));
    }

    http.end();
  }

  delay(1000); // Adjust delay as needed
}
