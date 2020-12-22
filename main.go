//${GOROOT}/bin/go run $0 $@ ; exit

/*
	Docker example; 
	how to run:
	$ NAME=Ewan ./main.go
	$ docker run hello-uncle
	$ docker run -e NAME=Andreas hello-uncle
*/
package main

import (
	"fmt"
	"os"
)

func main() {
	// fmt.Println(os.Getenv("NAME") + " is your uncle.")
	fmt.Printf("%v is your uncle.\n",os.Getenv("NAME"))
}
