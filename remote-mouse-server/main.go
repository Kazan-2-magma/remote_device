package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"time"
	"github.com/go-vgo/robotgo"
	"github.com/gorilla/websocket"
)

type Event struct {
	Action string  `json:"action"`
	Dx     float64 `json:"dx"`
	Dy     float64 `json:"dy"`
	Key string `json:"key"`
	Modifiers []string `json:"modifiers"`
}

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
}

func handler(w http.ResponseWriter, r *http.Request) {

	conn, err := upgrader.Upgrade(w, r, nil)


	if err != nil {
		log.Println("Upgrade error:", err)
		return
	}
	log.Println(conn);

	defer conn.Close()

	for {
		_, msg, err := conn.ReadMessage()
		if err != nil {
			log.Println("Read error:", err)
			break
		}

		log.Println("Raw message from Flutter:", string(msg))


		var e Event
		if err := json.Unmarshal(msg, &e); err != nil {
			log.Println("JSON error:", err)
			continue
		}
		
		switch e.Action {
		case "MOVE":
   			robotgo.MoveRelative(int(e.Dx*5), int(e.Dy*5))
		case "CLICK":
			robotgo.Click()
		case "RIGHT_CLICK":
			robotgo.Click("right");
		case "KEY":
			if(len(e.Modifiers) > 0){
				// Example: e.Key = "a", or "enter", "space"
				robotgo.KeyTap(e.Key,e.Modifiers)
			}else {
				robotgo.KeyTap(e.Key)
			}
		}
	}
}

func main() {

	go func() {
			addr, _ := net.ResolveUDPAddr("udp4", "255.255.255.255:9999")
			conn, _ := net.DialUDP("udp4", nil, addr)

			host,err := os.Hostname()

			if err != nil {
				host = "unknown";
			}
			localIP := getLocalIp()

			msg := fmt.Sprintf(
				`{"type":"SERVER","address" : "%s","port":8000,"name":"%s","version":"1.0","protocol":"ws"}`,
				localIP,
				host,
			)
			for {
				conn.Write([]byte(msg))
				time.Sleep(1 * time.Second)
			}
	}()

	http.HandleFunc("/", handler)
	fmt.Println("Server running on :8000")
	log.Fatal(http.ListenAndServe(":8000", nil))
}


func getLocalIp() string {

	conn,err := net.Dial("udp","8.8.8.8:80")

	if err != nil {
        return "unknown"
    }
    defer conn.Close()

    localAddr := conn.LocalAddr().(*net.UDPAddr)

    return localAddr.IP.String()

}
