extends Node

signal minerals_bg_updated

var minerals_bg : int = 0:
	set(value):
		minerals_bg += value
		minerals_bg_updated.emit()
