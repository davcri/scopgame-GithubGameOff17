extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var textlabel
var message= ["steam sales are coming","you must buy","mattia è nabbo"]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_DreamLordTrigger_body_enter( body ):
	textlabel = get_node("RichTextLabel")
	if body.get_name() == "Player":
		textlabel.revealText(body, message)
	pass