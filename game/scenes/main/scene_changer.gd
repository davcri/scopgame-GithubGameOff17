extends Node


func _on_Level1Button_pressed():
	get_tree().change_scene("game/scenes/level1/World.tscn")


func _on_SmartphoneButton_pressed():
	get_tree().change_scene("game/scenes/common/PuzzleSmartphone/Smartphone.tscn")


func _on_SleepParalysisButton_pressed():
	get_tree().change_scene("game/scenes/common/PuzzleSleepParalysis/SleepParalysis.tscn")


func _on_ShadersAndLightsButton_pressed():
	get_tree().change_scene("game/scenes/common/TestScenes/ShadersAndLights/ShadersAndLights.tscn")


func _on_TilePlacingButton_pressed():
	get_tree().change_scene("game/scenes/common/TestScenes/TilePlacement/TilePlacement.tscn")
