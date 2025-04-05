package utils

import (
	"fmt"
	"strings"
)

const (
	Reset         BlockColor = "\033[0m"
	Black         BlockColor = "\033[30m"
	Red           BlockColor = "\033[31m"
	Green         BlockColor = "\033[32m"
	Yellow        BlockColor = "\033[33m"
	Blue          BlockColor = "\033[34m"
	Magenta       BlockColor = "\033[35m"
	Cyan          BlockColor = "\033[36m"
	White         BlockColor = "\033[37m"
	Gray          BlockColor = "\033[90m"
	BrightRed     BlockColor = "\033[91m"
	BrightGreen   BlockColor = "\033[92m"
	BrightYellow  BlockColor = "\033[93m"
	BrightBlue    BlockColor = "\033[94m"
	BrightMagenta BlockColor = "\033[95m"
	BrightCyan    BlockColor = "\033[96m"
	BrightWhite   BlockColor = "\033[97m"
)

type (
	BlockColor string

	Entry interface {
		PrintOver(padding, width int)
		GetMaxLength() int
	}

	BlockItem struct {
		Typ   string
		Value string
		Color BlockColor
	}

	CenterBlock struct {
		BlockItem
	}

	GapBlock struct{}

	EntryBlock struct {
		Title BlockItem
		Value BlockItem
	}
)

func (eb *BlockItem) PrintOver(padding, width int) {
	drawItem(*eb, padding, width)
}

func (eb *CenterBlock) PrintOver(padding, width int) {
	drawCenterItem(eb.BlockItem, padding, width)
}

func (eb *BlockItem) GetMaxLength() int {
	return len(strings.TrimSpace(eb.Value))
}

func (eb *EntryBlock) PrintOver(padding, width int) {
	drawItem(eb.Title, padding, width)
	drawItem(eb.Value, padding, width)
}

func (eb *EntryBlock) GetMaxLength() int {
	titleLength := len(strings.TrimSpace(eb.Title.Value))
	valueLength := len(strings.TrimSpace(eb.Value.Value))

	if titleLength > valueLength {
		return titleLength
	}

	return valueLength
}

func (eb *GapBlock) PrintOver(padding, width int) {
	drawEmptyItem(padding, width)
}

func (eb *GapBlock) GetMaxLength() int {
	return 0
}

func findMinWidth(blocks []Entry) int {
	maxLength := 0

	for _, block := range blocks {
		current := block.GetMaxLength()

		if current > maxLength {
			maxLength = current
		}
	}

	return maxLength
}

func DrawRectangle(entries []Entry) {
	padding := 2
	minWidth := findMinWidth(entries)
	width := minWidth + 2*padding + 2

	drawLine(Blue, width)

	for index, entry := range entries {
		entry.PrintOver(padding, minWidth)

		if index < len(entries)-1 {
			drawEmptyItem(padding, minWidth)
		}
	}

	drawLine(Blue, width)
}

func drawLine(color BlockColor, width int) {
	fmt.Println(string(color) + "+" + strings.Repeat("-", width-2) + "+" + string(Reset))
}

func drawEmptyItem(padding, width int) {
	var emptyItem = BlockItem{
		Value: "",
		Color: Reset,
	}

	drawItem(emptyItem, padding, width)
}

func drawCenterItem(item BlockItem, padding, width int) {
	remainingSpace := width + padding - len(item.Value)
	currentPadding := (remainingSpace) / 2
	distPadding := padding / 2
	offset := 0

	if remainingSpace%2 != 0 {
		offset++
	}

	paddedOutput := fmt.Sprintf("|%s%s%s%s%s|",
		strings.Repeat(" ", distPadding+currentPadding+offset),
		item.Color,
		item.Value,
		Reset,
		strings.Repeat(" ", distPadding+currentPadding))

	fmt.Println(paddedOutput)
}

func drawItem(item BlockItem, padding, minWidth int) {
	currentPadding := minWidth - len(item.Value) + padding

	paddedOutput := fmt.Sprintf("|%s%s%s%s%s|",
		strings.Repeat(" ", padding),
		item.Color,
		item.Value,
		Reset,
		strings.Repeat(" ", currentPadding))

	fmt.Println(paddedOutput)
}
