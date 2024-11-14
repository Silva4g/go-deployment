package main
#bla
import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "oi oi oi oi oi oi oi oi oi oi oi")
	})
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
