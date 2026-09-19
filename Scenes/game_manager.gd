extends Node

var score: int = 0
@onready var book_counter: Label = $HUD/BookCounter
func add_point():
	score += 1
	book_counter.text = "Books Found: " + str(score) + "/5"
	print(score)
