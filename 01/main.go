package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	lines, err := read_to_array("input.txt")
	if err != nil {
		fmt.Println("Error reading input:", err)
	}
	fmt.Printf("Found %d increases.\n", increases(lines))
	grouped := grouped_by(3, lines)
	fmt.Printf("Grouped %d increases.\n", increases(grouped))
}

// Read from a file and coerce into an Array.
func read_to_array(filename string) ([]int, error) {
	file, err := os.Open("input.txt")
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []int

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		nextNumb, err := strconv.Atoi(scanner.Text())
		if err != nil {
			log.Println(err)
		}
		lines = append(lines, nextNumb)
	}
	if err := scanner.Err(); err != nil {
		return nil, err
	}
	return lines, nil
}

func grouped_by(group_size int, numbers []int) []int {
	var results []int

	for index, _ := range numbers {
		if index+group_size > len(numbers) {
			break
		}
		group := 0
		for i := 0; i < group_size; i++ {
			group += numbers[index+i]
		}
		results = append(results, group)
	}
	return results
}

func increases(numbers []int) int {
	lastNumb := 0
	increases := 0
	for _, nextNumb := range numbers {
		if lastNumb == 0 {
			// Do nothing
		} else if nextNumb > lastNumb {
			increases += 1
		}
		lastNumb = nextNumb
	}
	return increases
}
