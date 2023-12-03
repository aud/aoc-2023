package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

type GameSubset struct {
	red   int
	green int
	blue  int
}

type Game struct {
	id      int
	subsets []GameSubset
}

// Lets use a more verbose bufio strategy instead of io/ioutil get newline
// avoidance for free.
func readInput(fileName string) ([]string, error) {
	file, err := os.Open(fileName)
	if err != nil {
		return nil, err
	}

	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return lines, nil
}

func part1(input []string) string {
	// Go through each line of input
	// For each line, parse out the game into information segmented by:
	// Game {
	//   id int
	//   []subset {
	//     red int
	//     green int
	//     blue int
	//   }
	// }

	// The Elf would first like to know which games would have been possible if
	// the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
	//
	// Go through each subset for each game, fail fast if the bag exceeds those ^
	// If they succeed, add gameId to counter
	// return sum

	games := []Game{}
	for _, line := range input {
		parts := strings.Split(line, ":")

		r := regexp.MustCompile(`\d+`)

		gameId, err := strconv.Atoi(r.FindString(parts[0]))

		if err != nil {
			panic(err)
		}

		subsets := []GameSubset{}

        for _, subsetPart := range strings.Split(parts[1], ";") {
            fmt.Println(subsetPart)
        }

        return ""


		// Imagine in a for loop

		subset := GameSubset{
			red:   1,
			blue:  2,
			green: 3,
		}
		subsets = append(subsets, subset)

		game := Game{
			id:      gameId,
			subsets: subsets,
		}

		games = append(games, game)
	}

	fmt.Println(games)

	return ""
}

func main() {
	input, err := readInput("./day1_input.txt")

	if err != nil {
		panic(err)
	}

	fmt.Println(fmt.Sprintf("Part 1: %s", part1(input)))
}
