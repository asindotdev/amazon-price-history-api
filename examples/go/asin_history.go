// Price History of Any ASIN – Go example
// Usage: ASIN_API_KEY=your-key go run asin_history.go
package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"os"
	"time"
)

var client = &http.Client{Timeout: 120 * time.Second}

func call(method, target string, body []byte) []byte {
	var reader io.Reader
	if body != nil {
		reader = bytes.NewReader(body)
	}
	req, _ := http.NewRequest(method, target, reader)
	req.Header.Set("Authorization", "Bearer "+os.Getenv("ASIN_API_KEY"))
	if body != nil {
		req.Header.Set("Content-Type", "application/json")
	}
	resp, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
	data, _ := io.ReadAll(resp.Body)
	if resp.StatusCode >= 400 {
		fmt.Fprintf(os.Stderr, "HTTP %d: %s\n", resp.StatusCode, data)
		os.Exit(1)
	}
	return data
}

func main() {
	_ = url.Values{}
	_ = json.Valid
	params := url.Values{}
	params.Set("asin", "B09DFCB66S")
	params.Set("marketplace", "com")
	params.Set("days", "90")
	target := "https://www.asin.dev/api/v1/history"
	if len(params) > 0 {
		target += "?" + params.Encode()
	}
	data := call("GET", target, nil)
	var pretty bytes.Buffer
	json.Indent(&pretty, data, "", "  ")
	fmt.Println(pretty.String())
}
