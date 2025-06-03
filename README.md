# 🚗 Smart Parking System – Embedded Systems Project

This project implements an intelligent parking system with automated control, real-time communication, and a mobile interface. It was developed as part of the **Embedded Systems** course at FCUP.

## 📋 Objectives

- Automate car park management
- Detect the presence of vehicles in real time
- Allow users to book and cancel parking spots via app
- Alert users in case of emergencies (e.g. fire)
- Provide visual and audio feedback both locally and remotely

## 🧩 Features

- 📱 **Android mobile app** for real-time monitoring and control
- 🔄 **Real-time synchronisation** between all components via gRPC and Bluetooth
- 🛑 **Audio and visual alarm** in emergency scenarios
- 🔥 Fire detection and alert notifications
- 💡 RGB LEDs to indicate spot status (free, occupied, reserved, emergency)
- 🧱 Modular and scalable architecture supporting multiple park sections

## 🛠 Hardware Components

- **Arduino** (1 per 3 parking spaces)
- **Raspberry Pi** (central server)
- **Pressure sensors** (vehicle detection)
- **Temperature sensor** (fire detection)
- **Infrared sensors** (entry/exit detection)
- **RGB LEDs**, **LCD Display**, **Buzzer**
- **Bluetooth modules** (HC-05)
- **Android device**

## 🧪 Requirements
### Functional Requirements

- Automatic vehicle detection via pressure sensors
- Spot status indication (free/reserved/occupied/emergency)
- Mobile app control and visualisation
- Fire alert system and notifications
- Real-time LED, display and app updates
- Support for multiple users simultaneously

### Non-Functional Requirements

- Vehicle detection ≤ 1 second
- Vehicle removal detection ≤ 2 seconds
- Smartphone updates ≤ 2 seconds
- Smartphone-to-smartphone sync ≤ 1 second
- Fire detection ≤ 1 second *(not fully met)*
- Alarm response ≤ 2 seconds
- LED update ≤ 1 second
- Real-time data sync and in-app authentication

## 🖧 Architecture Overview

- **Raspberry Pi ↔ Arduinos:** Bluetooth communication
- **Mobile App ↔ Raspberry Pi:** Wi-Fi via gRPC (HTTP/2)
- Raspberry Pi handles multi-threading, component handlers, Redis DB, and control logic
- Flutter app with secure communication and user interface

## 📁 Project Structure

This repository is organised into the following key components:

- **`arduino/`**: Source code for embedded devices responsible for vehicle detection, space state management, and barrier control.
- **`server/`**: Backend service built with gRPC and containerised using Docker to streamline development and deployment.
- **`mobile/`**: Mobile application allowing users to interact with the system, view space availability, and manage reservations.
- **`proto/`**: Protocol Buffer definitions that establish the communication structure between system components using gRPC.
- **`Makefile`**: Automation script for common development tasks, including tool installation and code generation.

## ⚙️ Running the Project

### Prerequisites

- PlatformIO (for Arduino firmware)
- Go (for backend)
- Docker & Docker Compose (for Redis)
- Flutter SDK (for mobile app)


### To prepare your development environment and generate necessary files, run:

```bash
make install-tools
make gen-proto
```

To launch the server locally using Docker:

```bash
make serve-server
```

To shut down the server:

```bash
make take-server
```

## 🛠️ Makefile Commands
To view available commands:

```bash
make
```

Help output:

```text
Makefile for managing Project tools

Tools:
  install-tools                 - Download and install proto-related tools

Actions:
  serve-server                  - Start the backend server locally using Docker
  take-server                   - Stop the backend server
  gen-proto                     - Generate protocol buffer files for both server and mobile components
```
