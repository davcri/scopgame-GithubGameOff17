extends Node


func _on_Level1Button_pressed():
	get_tree().change_scene("./game/scenes/level1/World.tscn")

func _on_SmartphoneButton_pressed():
	get_tree().change_scene("./game/scenes/common/PuzzleSmartphone/Smartphone.tscn")