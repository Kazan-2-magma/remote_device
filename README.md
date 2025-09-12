## Remote Mouse & Keyboard Controller

Control your PC keyboard and mouse directly from your phone.
This project combines a Go backend (using RobotGo) with a Flutter mobile app to give you remote control over your device.

---

##  Features
- 🖱️ **Mouse control**: move, click, scroll from your phone
- ⌨️ **Keyboard control**: type in real-time, including special keys
- 📡 **Cross-platform**:  
  - Server runs on Linux (tested on Ubuntu/Mint)  
  - Flutter app runs on Android
- 🔒 Local network connection only (WiFi LAN)

---

##  Tech Stack

# Go (backend server)

RobotGo → simulate native keyboard & mouse events

TCP sockets → handle all real-time events

UDP broadcast → make devices discoverable on the LAN

Flutter (mobile client)

Cross-platform UI for Android

Socket connection to the Go server

Gesture → Mouse mapping (drag = move, tap = click, etc.)

On-screen keyboard → Remote key events
---

## Network Protocols
🔹 UDP (Discovery)

Phone sends a broadcast → PC responds with its IP and device name

This allows the app to list available PCs on the same WiFi

🔹 TCP (Events)

Used for all control events:

Mouse movement

Mouse clicks & scroll

Keyboard input (letters, numbers, special keys)

Reliable delivery ensures no lost keystrokes or clicks

👉 Final setup:

UDP → discovery only

TCP → mouse + keyboard events

## 🚀 Getting Started

### 1. Run the Go Server
Clone the repo and build the Go backend:
```bash
git clone https://github.com/Kazan-2-magma/remote-mouse-server.git
cd remote-mouse-server

# Build binary
go build -o remote-device

# Run server (default port 8000)
./remote-device


