# 🚀 RadarLite – 360° Ultrasonic Object Detection & Visualization

![Platform](https://img.shields.io/badge/Platform-ESP32--C6-blue)
![Interface](https://img.shields.io/badge/Visualization-Processing-green)
![System](https://img.shields.io/badge/Linux-antiX--Debian--based-lightgrey)

**Duration:** June 2025  

---

## 🌐 Overview

**RadarLite** is a radar-like environmental scanning system that uses an **ESP32-C6 Mini**, a **continuous rotation servo**, and an **ultrasonic sensor** to detect objects in a 360° field. The sensor captures distance data as it rotates forward and backward, and transmits this data via serial communication to a **Processing** app, which visualizes the scanned environment in real time.

> Compact, responsive, and ideal for real-time visualization of physical spaces in robotics and embedded systems research.

---

## 💻 Key Features

- 📏 **360° Object Detection** using ultrasonic sensing  
- 🔁 **Bidirectional Scanning** with time-based servo angle approximation  
- 🔌 **Serial Communication** between ESP32 and PC (USB)  
- 📈 **Real-Time Visualization** via the Processing IDE  
- 🧰 **Code Uploaded using Arduino CLI** on lightweight Linux OS (antiX)

---

## 🔧 Tech Stack

| Component                      | Description                                 |
|-------------------------------|---------------------------------------------|
| **ESP32-C6 Mini**             | Wi-Fi enabled microcontroller (ESP chip)    |
| **HC-SR04 Ultrasonic Sensor** | Measures distance to nearby objects         |
| **Continuous Servo Motor**    | Rotates sensor continuously in both directions |
| **Processing**                | Visualizes sensor data as radar scans       |
| **Arduino CLI**               | Command-line firmware flashing              |
| **Linux (antiX)**             | Lightweight Debian-based development OS     |

---

## 🔁 How It Works

1. **Rotation Logic:** Servo motor rotates the ultrasonic sensor across ~360°.
2. **Sensing:** At time-based angular steps, HC-SR04 records distance values.
3. **Data Stream:** (angle, distance) data pairs are sent via USB serial.
4. **Visualization:** Processing app receives serial data and plots a radar sweep in real time.

---

## 📲 Use Cases

- Obstacle Mapping in Robotics  
- DIY Radar Simulation Projects  
- Embedded Systems Visualization Demos  
- Linux-based IoT Prototyping  
- Educational Tools for Sensor Integration

---


## 🔧 Getting Started

### 🛠️ Hardware Requirements

- ✅ ESP32-C6 Mini  
- ✅ HC-SR04 Ultrasonic Sensor  
- ✅ Continuous Rotation Servo Motor (e.g., FS90R or SG90 modified)  
- ✅ Breadboard, Jumper Wires, and Power Source  
- ✅ USB Cable (for serial connection)  

### 🔗 Software Requirements

- [Arduino CLI](https://arduino.github.io/arduino-cli/latest/)  
- [Processing IDE](https://processing.org/download/)  
- Compatible Linux OS (Tested on antiX – Debian lightweight)  

---

## 🎥 YouTube Demo

Experience **RadarLite** in action with real-time rotation, scanning, and data visualization:

[![Watch the Demo](https://img.shields.io/badge/Watch-Demo-red?logo=youtube)](https://youtu.be/zf8WgtXcOnU)


---



