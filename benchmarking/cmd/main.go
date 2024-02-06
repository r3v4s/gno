package main

import (
	"encoding/binary"
	"fmt"
	"os"
	"sync"

	"github.com/gnolang/gno/gnovm/pkg/gnolang"
)

const recordSize int = 9

func main() {
	file, err := os.Open("/Users/dylan/deelawn/gnoland/fork/gno/gno.land/benchmarks.log")
	if err != nil {
		panic("could not create benchmark file: " + err.Error())
	}

	inputCh := make(chan []byte, 10000)
	outputCh := make(chan string, 10000)
	wg := sync.WaitGroup{}
	numWorkers := 4
	wg.Add(numWorkers)

	doneCh := make(chan struct{})

	for i := 0; i < numWorkers; i++ {
		go func() {
			for {
				buf, ok := <-inputCh
				if !ok {
					break
				}
				op := gnolang.Op(buf[0])
				elapsedTime := binary.LittleEndian.Uint32(buf[1:])
				size := binary.LittleEndian.Uint32(buf[5:])
				outputCh <- op.String() + "," + fmt.Sprint(elapsedTime) + "," + fmt.Sprint(size)
			}
			wg.Done()
		}()
	}

	go func() {
		out, err := os.Create("results.csv")
		if err != nil {
			panic("could not create readable output file: " + err.Error())
		}

		fmt.Fprintln(out, "op,elapsedTime,diskIOBytes")

		for {
			output, ok := <-outputCh
			if !ok {
				break
			}

			fmt.Fprintln(out, output)
		}

		out.Close()
		doneCh <- struct{}{}
	}()

	var i int
	bufSize := recordSize * 100000
	for {
		buf := make([]byte, bufSize)
		if n, err := file.Read(buf); err != nil && n == 0 {
			break
		}

		for j := 0; j < len(buf)/recordSize; j += recordSize {
			inputCh <- buf[j : j+recordSize]
		}

		i += bufSize / recordSize
		if i%1000 == 0 {
			fmt.Println(i)
		}
	}

	close(inputCh)
	wg.Wait()
	close(outputCh)
	<-doneCh
	close(doneCh)

	fmt.Println("done")
}
