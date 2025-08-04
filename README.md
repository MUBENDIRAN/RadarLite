# 🚀 RadarLite – 360° Ultrasonic Object Detection & Visualization

![Platform](https://img.shields.io/badge/Platform-ESP32--C6-blue)
![Interface](https://img.shields.io/badge/Visualization-Processing-green)
![System](https://img.shields.io/badge/Linux-antiX--Debian--based-lightgrey)

**Duration:** June 2025  
**Affiliation:** Rajalakshmi Institute of Technology

---

## 🌐 Overview

**RadarLite** is a radar-like environmental scanning system that uses an **ESP32-C6 Mini**, a **continuous rotation servo**, and an **ultrasonic sensor** to detect objects in a 360° field. The sensor captures distance data as it rotates forward and backward, and transmits this data via serial communication to a **Java-based Processing** app, which visualizes the scanned environment in real time.

---

## 💻 Key Features

- 📏 **360° Object Detection** using ultrasonic sensing  
- 🔁 **Bidirectional Scanning** with time-based servo angle approximation  
- 🔌 **Serial Communication** between ESP32 and PC (USB)  
- 📈 **Real-Time Visualization** via the Processing IDE  
- 🧰 **Code Uploaded using Arduino CLI** on lightweight Linux OS (antiX)

---

## 🔧 Tech Stack

| Component                  | Description                                |
|----------------------------|--------------------------------------------|
| **ESP32-C6 Mini**          | Wi-Fi enabled microcontroller (ESP chip)   |
| **HC-SR04 Ultrasonic Sensor** | Measures distance to nearby objects    |
| **Continuous Servo**       | Rotates sensor continuously in both directions |
| **Processing (Java)**      | Real-time environment visualization        |
| **Arduino CLI**            | CLI-based firmware flashing tool           |
| **Linux (antiX)**          | Lightweight Debian-based OS used for dev   |

---

## 🔁 How It Works

1. **Rotation Logic:** Servo rotates the sensor forward to ~360° and reverses.
2. **Sensing:** At each approximate angle, HC-SR04 records object distance.
3. **Transmission:** Data (angle + distance) is sent to PC via serial port.
4. **Visualization:** Processing app reads and plots data to form a radar map.

---

## 📲 Use Cases

- Obstacle Mapping in Robotics  
- DIY Radar Simulation Projects  
- Embedded Systems Visualization Demos  
- Linux-based IoT Prototyping

---

## 🧠 Skills Demonstrated

- Embedded C with Arduino  
- Linux Terminal + Arduino CLI  
- Serial Communication Protocol  
- Java Programming in Processing  
- Sensor Integration and Data Parsing  
- Real-Time Visualization Techniques

---

## 🔧 Getting Started

### Hardware:
- ESP32-C6 Mini
- HC-SR04 Ultrasonic Sensor
- Continuous Rotation Servo (FS90R or SG90 modified)
- Jumper wires + Breadboard

### Software:
- Arduino CLI installed on Linux (antiX)
- Java-based Processing IDE
- Serial port configuration

---

## 🎵 Music Credit

- Background Music (for demo): [Elektronomia – Sky High (NCS)](https://youtu.be/TW9d8vYrVFQ)

---

## 👨‍💻 Author

**Mubendiran K**  
[GitHub](https://github.com/MUBENDIRAN) • [LinkedIn](https://www.linkedin.com/in/mubendiran-k)  

---

> _“RadarLite transforms low-cost components into an intelligent 360° scanner—real-time, visual, and minimalistic.”_

