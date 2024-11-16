#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <TM1637Display.h>  // Include the TM1637 display library

#define coinSlot D3  // PIN 8 for the coin slot
// TM1637 7-segment display setup
#define CLK  D1  // Connect CLK pin to D1
#define DIO  D2  // Connect DIO pin to D2

const char* ssid = "Marron";              // Your WiFi SSID
const char* password = "543210123";       // Your WiFi password

// Server URL
const char* serverName = "http://192.168.0.117/SunChargeV2/function/send_sales_c1.php"; // Replace with your actual URL C:\xampp\htdocs\SunChargeV2\function

// Data to be sent
int charging1 = 0;       // Value to be sent to server for charging1

int coinSlotStatus;
int pulse = 0; // Coin pulse counter
int remainingTime = 0; // Time remaining in seconds

// Variables to accumulate charging values
unsigned long lastSendTime = 0; // Time of last sending
const unsigned long sendInterval = 30000; // Send data every 30 seconds

unsigned long lastMillis = 0;
const int COIN_TO_SECONDS = 60; // Each coin pulse adds 60 seconds (1 minute)

boolean balance = false;
boolean noCoin = false;
TM1637Display display(CLK, DIO);

void setup() {
  Serial.begin(9600); // Start serial communication
  Serial.println("Connecting to WiFi...");

  pinMode(coinSlot, INPUT_PULLUP); // Coin slot setup

  WiFi.begin(ssid, password); // Start WiFi connection

  // Check WiFi status and wait until connected
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nConnected to WiFi!");

  // Initialize the 7-segment display
  display.setBrightness(7);  // Set brightness from 0 to 7 (0 = dim, 7 = bright)
}

void loop() {
  // Check coin slot status
  coinSlotStatus = digitalRead(coinSlot);

  if (noCoin == false) {
    noCoin = true;
    Serial.println("Please insert a coin.");
  }

  // Detect coin insertion
  if (coinSlotStatus == LOW) {
    pulse++; // Increment pulse count for each coin detected
    balance = true;
    remainingTime += COIN_TO_SECONDS; // Add 1 minute for each coin detected
    Serial.println("Coin detected! Adding time...");
  }

  // Charging countdown if remaining time is more than zero
  if (remainingTime > 0 && millis() - lastMillis >= 1000 && balance) {
    lastMillis = millis();
    remainingTime--;

    int minutes = remainingTime / 60;
    int seconds = remainingTime % 60;

    // Print to serial monitor
    Serial.print("Remaining time: ");
    Serial.print(minutes);
    Serial.print(":");
    Serial.println(seconds < 10 ? "0" + String(seconds) : String(seconds));

    // Display on 7-segment display
    display.showNumberDecEx(minutes * 100 + seconds, 0b11100000, true);  // Show MM:SS
  }

  // Send pulse data every 30 seconds
  if (millis() - lastSendTime >= sendInterval) {
    // Set charging1 to the current pulse value
    charging1 = pulse;
    // Send data to the server
    sendData(charging1);
    // Reset pulse count and charging1 after sending
    pulse = 0; // Reset pulse count after sending
    charging1 = pulse; // Reset charging1 value
    lastSendTime = millis(); // Update the last send time
  }

  delay(50); // Adjust delay as needed
}

void sendData(int charging1) {
  if (WiFi.status() == WL_CONNECTED) {
    WiFiClient client;
    HTTPClient http;

    // Construct URL with parameters
    String url = String(serverName) + "?charging1=" + String(charging1);
    Serial.println("Sending request to URL: " + url); // Debugging line

    // Begin HTTP connection
    http.begin(client, url);
    int httpResponseCode = http.GET();

    // Check for server response
    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println("Server response: " + response);
    } else {
      Serial.println("Error in HTTP request: " + String(httpResponseCode));
    }

    http.end(); // Close connection
  } else {
    Serial.println("WiFi not connected");
  }
}
