package main

import (
	"fmt"
	"net"
	"runtime"
	"strconv"
	"time"
)

func Connect(host string, port int) {
	_, err := net.Dial("tcp", host+":"+strconv.Itoa(port))
	if err != nil {
		fmt.Println("Dial fail")
		return
	}
	for {
		time.Sleep(time.Second)
	}
}

func main() {
	count := 0
	for {
		go Connect("localhost", 9000)
		count ++
		fmt.Printf("Gorutue num:%d  \n", runtime.NumGoroutine())
		time.Sleep(100 * time.Millisecond)
	}
}
