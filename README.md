# ParkSense – Modular Parking Management System

**ParkSense** is a modular embedded system designed to manage car parks using a plugin-based architecture. The project integrates embedded hardware (Arduino), a backend service (gRPC with Docker), and a mobile application, ensuring scalability, flexibility, and ease of maintenance.

## 📁 Project Structure

This repository is organised into the following key components:

- **`arduino/`**: Source code for embedded devices responsible for vehicle detection, space state management, and barrier control.
- **`server/`**: Backend service built with gRPC and containerised using Docker to streamline development and deployment.
- **`mobile/`**: Mobile application allowing users to interact with the system, view space availability, and manage reservations.
- **`proto/`**: Protocol Buffer definitions that establish the communication structure between system components using gRPC.
- **`Makefile`**: Automation script for common development tasks, including tool installation and code generation.

## ⚙️ Getting Started

To prepare your development environment and generate necessary files, run:

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