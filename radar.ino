/*
  HC‑SR04 Ultrasonic + CR‑Servo 360° Scanner
  v3.3 – 21 Jun 2025 (Calibrated for 360° full turn)

  Target MCU : WeAct ESP32‑C6 Mini
  Servo      : Continuous SG90 – GPIO14
  Ultrasonic : HC‑SR04 – TRIG: GPIO2, ECHO: GPIO3
  Output     : <angle>,<distance_cm>
*/

#include <ESP32Servo.h>  // ESP32-compatible Servo library

/* ---------- Pin Config ---------- */
constexpr uint8_t PIN_TRIG   = 2;
constexpr uint8_t PIN_ECHO   = 3;
constexpr uint8_t PIN_SERVO  = 14;

/* ---------- Servo + Ultrasonic Constants ---------- */
constexpr float SOUND_SPEED_CM_PER_US = 0.0343f;
constexpr uint16_t MAX_DISTANCE_CM    = 300;

constexpr uint16_t SERVO_STOP_US      = 1500;  // Neutral pulse
constexpr uint16_t SERVO_CW_US        = 1700;  // Slight clockwise speed
constexpr uint16_t SERVO_CCW_US       = 1300;  // Slight counterclockwise
constexpr uint32_t FULL_REV_MS        = 800;   // ← Calibrated 360° turn time
constexpr uint8_t  NUM_REVS           = 2;     // One full rotation
constexpr uint16_t DWELL_MS           = 300;   // Pause between direction changes
constexpr uint16_t READ_INTERVAL_MS   = 60;    // Sampling delay

Servo motor;

void setup() {
  Serial.begin(115200);
  pinMode(PIN_TRIG, OUTPUT);
  pinMode(PIN_ECHO, INPUT);

  motor.setPeriodHertz(50);
  motor.attach(PIN_SERVO, 1000, 2000);
  motor.writeMicroseconds(SERVO_STOP_US);
  delay(500);  // Allow time for stabilization
}

void loop() {
  rotateRevs(true,  NUM_REVS);  // Clockwise
  delay(DWELL_MS);
  rotateRevs(false, NUM_REVS);  // Counter-clockwise
  delay(DWELL_MS);
}

void rotateRevs(bool clockwise, uint8_t revs) {
  const uint16_t pulseWidth = clockwise ? SERVO_CW_US : SERVO_CCW_US;
  const uint32_t runTime    = uint32_t(revs) * FULL_REV_MS;
  const uint32_t startTime  = millis();

  while (millis() - startTime < runTime) {
    motor.writeMicroseconds(pulseWidth);
    float progress = float(millis() - startTime) / FULL_REV_MS;
    uint16_t angle = uint16_t(progress * 360.0f) % 360;
    if (!clockwise) angle = (360 - angle) % 360;

    int distance = readUltrasonicCM();

    Serial.print(angle);
    Serial.print(',');
    Serial.println(distance);

    delay(READ_INTERVAL_MS);
  }

  motor.writeMicroseconds(SERVO_STOP_US);  // Brake
  delay(300);  // Ensure full stop
}

int readUltrasonicCM() {
  digitalWrite(PIN_TRIG, LOW);
  delayMicroseconds(2);
  digitalWrite(PIN_TRIG, HIGH);
  delayMicroseconds(10);
  digitalWrite(PIN_TRIG, LOW);

  long duration = pulseIn(PIN_ECHO, HIGH, 30000);  // 30ms timeout
  if (duration == 0) return -1;

  int distance = duration * SOUND_SPEED_CM_PER_US / 2.0f;
  return (distance > MAX_DISTANCE_CM) ? MAX_DISTANCE_CM : distance;
}
