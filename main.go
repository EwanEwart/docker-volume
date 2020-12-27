//${GOROOT}/bin/go run $0 $@ ; exit

package main

import (
    "bufio"
    "fmt"
    "log"
    "os"
    "strconv"
)

func main() {
	fmt.Printf("This program's binary → %v\n",os.Args[0])

    file, err := os.Create("./created-externally")
    if err != nil {
        log.Fatal(err)
    }
    writer := bufio.NewWriter(file)
    linesToWrite := [][]string{
        {"line 00"}, 
        {"line 01"}, 
        {"line 01","line 02",}, 
        {"line 01","line 02","line 03"}, 
        {"line 01","line 02","line 03","line 04"}, 
        {"line 01","line 02","line 03","line 04","line 05"}, 
    }
    i:=1
    arg1,err:=strconv.Atoi(os.Args[1])
    if err != nil {
        log.Fatal("arg1 conversion failure: %v\n", err.Error())
    }
    cntLines := len(linesToWrite)
    isAre:=map[bool]string{true: "is", false: "are"} [cntLines==1]
    lineLines:=map[bool]string{true: "line", false: "lines"} [cntLines==1]
    if arg1 >= cntLines || arg1 < 1 {
        log.Fatal("There ", isAre, " exactly ", cntLines-1, " ", lineLines, "; not more.\n")
    }
    for _, line := range linesToWrite[arg1] {
        bytesWritten, err := writer.WriteString(line + "\n")
        if err != nil {
            log.Fatalf("Got error while writing to a file. Err: %s", err.Error())
        }
        fmt.Printf("%2v. %-15v %v %10v\n",i,"Bytes Written", ":", bytesWritten)
        fmt.Printf("%2v. %-15v %v %10v\n",i,"Available    ", ":", writer.Available())
        fmt.Printf("%2v. %-15v %v %10v\n",i,"Buffered     ", ":", writer.Buffered())
        i++
    }
    writer.Flush()
}
