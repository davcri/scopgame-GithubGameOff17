extends Node2D
var dialog = ["Steam's Sales are coming "," You Must Buy","Mattia è nabbo"]
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_DreamLordTrigger_body_enter( body ):
	var Textlabel = get_node("RichTextLabel")
	if body.get_name() == "Player":
		Textlabel.revealText(body, dialog)
	pass # rplace with function b ody
