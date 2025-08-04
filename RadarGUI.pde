 /*
 * 360‑Degree Ultrasonic Radar Visualiser – v3.1 (21 Jun 2025)
 * -----------------------------------------------------------
 * Now with authentic military‑style detection markers:
 *   • Red concentric pulsing circles at detection point
 *   • Realistic target blink with sharp contrast
 *   • Radar sweep beam untouched for blue ATC style
 */

import processing.serial.*;

/* ---------- Serial ---------- */
Serial port;
int     angleDeg  = 0;
int     distanceCm= -1;
int     lastAngle = -1;
int     lastDist  = -1;

/* ---------- Echo Persistence ---------- */
final int MAX_CM_DISPLAY = 40;
final int DECAY_FRAMES    = 300;
int[] distHist  = new int[360];
int[] ageHist   = new int[360];

/* ---------- Sweep Visuals ---------- */
final float SWEEP_WIDTH_DEG = 2.5;
float pxPerCm;

void setup() {
  size(1000, 1000);
  smooth(8);
  frameRate(60);
  colorMode(RGB, 255, 255, 255, 255);

  pxPerCm = (min(width, height) * 0.46) / MAX_CM_DISPLAY;

  println(Serial.list());
  port = new Serial(this, "/dev/ttyACM0", 115200);
  port.bufferUntil('\n');

  textFont(createFont("Consolas", 18));
  java.util.Arrays.fill(distHist, -1);
}

void draw() {
  drawBackground();
  translate(width/2f, height/2f);
  drawGrid();
  drawMilitaryTargets();
  drawSweepSector();
  drawHUD();
}

void serialEvent(Serial p) {
  String line = trim(p.readStringUntil('\n'));
  if (line == null || line.length() == 0) return;
  String[] tok = split(line, ',');
  if (tok.length != 2) return;
  try {
    int a = constrain(int(tok[0]), 0, 359);
    int d = int(tok[1]);

    if (lastAngle != -1) {
      int step =  (a > lastAngle) ? 1 : -1;
      if (wrapDistance(lastAngle, a) > 180) step = -step;
      int cur = lastAngle;
      while (cur != a) {
        cur = (cur + step + 360) % 360;
        distHist[cur] = d;
        ageHist[cur]  = 0;
      }
    }

    angleDeg    = a;
    distanceCm  = d;
    distHist[a] = d;
    ageHist[a]  = 0;
    lastAngle   = a;
    lastDist    = d;
  } catch (Exception e) {}
}

void drawBackground() {
  noStroke();
  for (int i = 0; i < 100; i++) {
    float alpha = map(i, 0, 99, 25, 0);
    fill(0, alpha);
    ellipse(width/2f, height/2f, width * map(i, 0, 99, 0, 1.2), height * map(i, 0, 99, 0, 1.2));
  }
}

void drawGrid() {
  noFill();
  stroke(0, 180, 0, 140);
  strokeWeight(1.2);

  for (int i = 1; i <= 4; i++) {
    float r = pxPerCm * MAX_CM_DISPLAY * i / 4f;
    ellipse(0, 0, r*2, r*2);
  }

  for (int a = 0; a < 360; a += 30) {
    float x = cos(radians(a)) * pxPerCm * MAX_CM_DISPLAY;
    float y = sin(radians(a)) * pxPerCm * MAX_CM_DISPLAY;
    line(0, 0, x, y);
  }
}

void drawMilitaryTargets() {
  for (int a = 0; a < 360; a++) {
    if (distHist[a] <= 0 || distHist[a] > MAX_CM_DISPLAY) continue;
    float r = distHist[a] * pxPerCm;
    float x = cos(radians(a)) * r;
    float y = sin(radians(a)) * r;

    float alpha = map(ageHist[a], 0, DECAY_FRAMES, 255, 0);
    if (alpha <= 0) {
      distHist[a] = -1;
      continue;
    }

    float pulse = 1 + 1.2 * sin(radians(frameCount * 5));
    stroke(255, 0, 0, alpha);
    strokeWeight(2);
    noFill();
    ellipse(x, y, 12 * pulse, 12 * pulse);
    ellipse(x, y, 5 * pulse, 5 * pulse);

    ageHist[a]++;
  }
}

void drawSweepSector() {
  pushMatrix();
  for (float w = -SWEEP_WIDTH_DEG; w <= SWEEP_WIDTH_DEG; w += 0.5) {
    float blend = map(abs(w), 0, SWEEP_WIDTH_DEG, 255, 50);
    stroke(0, 200, 255, blend);
    strokeWeight(1.3);
    float x = cos(radians(angleDeg + w)) * pxPerCm * MAX_CM_DISPLAY;
    float y = sin(radians(angleDeg + w)) * pxPerCm * MAX_CM_DISPLAY;
    line(0, 0, x, y);
  }
  popMatrix();
}

void drawHUD() {
  resetMatrix();
  fill(0, 200);
  noStroke();
  rect(0, height - 45, width, 45);
  fill(0, 255, 255);
  text(String.format("Heading: %3d°   Range: %3d cm", angleDeg, max(distanceCm, 0)), 12, height - 16);
}

int wrapDistance(int a, int b) {
  int diff = abs(a - b);
  return min(diff, 360 - diff);
}
