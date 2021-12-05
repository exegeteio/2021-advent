package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

type location struct {
	Distance, Depth, Aim int
}

func (loc *location) Move(direction string, distance int) {
	switch direction {
	case "up":
		loc.Aim -= distance
	case "down":
		loc.Aim += distance
	case "forward":
		loc.Distance += distance
		loc.Depth += distance * loc.Aim
	}
}

func main() {
	directions, distances, err := read_to_array("part1.txt")
	if err != nil {
		log.Fatal(err)
	}
	loc := location{0, 0, 1}
	for index, direction := range directions {
		loc.Move(direction, distances[index])
	}
	fmt.Printf("Depth:    %d\n", loc.Depth)
	fmt.Printf("Distance: %d\n", loc.Distance)
	fmt.Printf("Aim:      %d\n", loc.Aim)
	fmt.Printf("Square:   %d\n", loc.Distance*loc.Depth)
}

// Read from a file and coerce into an Array.
func read_to_array(filename string) ([]string, []int, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, nil, err
	}
	defer file.Close()

	var directions []string
	var distances []int

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		direction, distance, err := split_line(line)
		if err != nil {
			log.Fatal(err)
		}
		directions = append(directions, direction)
		distances = append(distances, distance)
	}
	if err := scanner.Err(); err != nil {
		return nil, nil, err
	}
	return directions, distances, err
}

func split_line(line string) (string, int, error) {
	parts := strings.Split(line, " ")
	distance, err := strconv.Atoi(parts[1])
	if err != nil {
		return "", 0, err
	}
	return parts[0], distance, nil
}
