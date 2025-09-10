# 📱💻 Remote Mouse & Keyboard Controller

Control your **PC keyboard and mouse** directly from your **phone**.  
This project combines a **Go backend** (using [RobotGo](https://github.com/go-vgo/robotgo)) with a **Flutter mobile app** to give you remote control over your device.

---

## ✨ Features
- 🖱️ **Mouse control**: move, click, scroll from your phone
- ⌨️ **Keyboard control**: type in real-time, including special keys
- 📡 **Cross-platform**:  
  - Server runs on Linux (tested on Ubuntu/Mint)  
  - Flutter app runs on Android
- ⚡ Lightweight Go backend (~10 MB binary, no external runtime needed)
- 🔒 Local network connection only (WiFi LAN)

---

## 🛠️ Tech Stack
- **Go** (backend server)
  - [RobotGo](https://github.com/go-vgo/robotgo) → handles native keyboard & mouse events
- **Flutter** (mobile client)
  - Cross-platform UI for Android
  - Connects to the Go server over TCP/WebSocket/HTTP (depending on your setup)

---

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
