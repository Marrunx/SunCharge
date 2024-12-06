#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <TM1637Display.h>  // Include the TM1637 display library

#define coinSlot D3           // PIN D3 for the coin slot
#define CLK D1                // TM1637 CLK pin
#define DIO D2                // TM1637 DIO pin

const char* ssid = "OPPOA17";              // Your WiFi SSID
const char* password = "jjuralbal";       // Your WiFi password

// Server URLs
const char* sendSalesURL = "http://192.168.249.63/SunChargeV2/function/send_sales_c2.php"; // Function for sending sales

int relayPin = D5;         // Relay connected to D5
int coinSlotStatus;
int remainingTime = 0;     // Time remaining in minutes
int pulse = 0;             // Coin pulse counter
int totalCoins = 0;        // Total coins inserted

unsigned long lastCoinTime = 0; // Time of the last coin insertion
unsigned long sendDelay = 2000; // Delay before sending total to server
unsigned long lastMillis = 0;
const int COIN_TO_SECONDS = 60; // Each coin pulse adds 60 seconds (1 minute)
unsigned long lastSecond = 0;  // Variable to track the last second change

boolean balance = false;
boolean noCoin = false;
boolean relayState = false; // Tracks if the relay is ON or OFF
TM1637Display display(CLK, DIO);

void setup() {
  Serial.begin(115200); // Start serial communication
  Serial.println("Connecting to WiFi...");

  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, LOW); // Ensure relay is off at start
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
  coinSlotStatus = digitalRead(coinSlot);


  if (noCoin == false) {
    noCoin = true;
    Serial.println("Please insert a coin.");
  }

  // Detect coin insertion
  if (coinSlotStatus == LOW) {
    pulse++; // Increment pulse count for each coin detected
    totalCoins++;  // Track total coins inserted
    balance = true;
    remainingTime += COIN_TO_SECONDS; // Add 1 minute for each coin detected
    Serial.println("Coin detected! Adding time...");
    relayState = true; // Ensure the relay is set to ON
    digitalWrite(relayPin, HIGH); // Turn on the relay
    lastCoinTime = millis();  // Reset the time for coin detection
  }

  // If no coin inserted for a while (e.g., 2 seconds), send the accumulated total
  if (millis() - lastCoinTime > sendDelay && totalCoins > 0) {
    send_sales_c1(totalCoins); // Send the accumulated total
    totalCoins = 0;  // Reset total coins after sending
  }

  // Manage relay and countdown
  if (remainingTime > 0 && millis() - lastMillis >= 1000 && balance) {  // Count down by 1 second
    lastMillis = millis();
    remainingTime--;

    int minutes = remainingTime / 60;
    int seconds = remainingTime % 60;

    // Ensure relay is ON
    if (!relayState) {
      digitalWrite(relayPin, HIGH);
      relayState = true;
    }

    // Print to serial monitor
    Serial.print("Remaining time: ");
    Serial.print(minutes);
    Serial.print(":");
    Serial.println(seconds < 10 ? "0" + String(seconds) : String(seconds));

    // Display on 7-segment display
    display.showNumberDecEx(minutes * 100 + seconds, 0b11100000, true);  // Show MM:SS
  } else if (remainingTime <= 0 && relayState) {
    // Turn off the relay only once when time runs out
    digitalWrite(relayPin, LOW);
    relayState = false; // Update relay state
    balance = false;    // Reset balance state
    Serial.println("Time is up! Relay turned off."); // Print only once
    display.showNumberDec(0, true); // Display 0 on 7-segment
  }

  delay(48); // Adjust delay as needed
}


// Function to send accumulated pulse data to the server (send_sales_c1.php)
void send_sales_c1(int charging2) {
  if (WiFi.status() == WL_CONNECTED) {
    WiFiClient client;
    HTTPClient http;

    // Construct URL with the accumulated total coins as the parameter
    String url = String(sendSalesURL) + "?charging2=" + String(charging2);
    Serial.println("Sending request to URL: " + url); // Debugging line

    // Begin HTTP connection
    http.begin(client, url);
    int httpResponseCode = http.GET();

    // Check for server response
    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println("Server response (sales): " + response);
    } else {
      Serial.println("Error in HTTP request: " + String(httpResponseCode));
    }

    http.end(); // Close connection
  } else {
    Serial.println("WiFi not connected");
  }
}

