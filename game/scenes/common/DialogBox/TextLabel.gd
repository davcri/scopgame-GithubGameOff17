#TextLabel
extends RichTextLabel
var pag = 0
var message
# class member variables go here, for example:

var timer
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	#
	set_visible_characters(0)

func _on_Timer_timeout():
	
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		if pag < message.size() -1:
			pag +=1
			set_bbcode(message[pag])
			set_visible_characters(0)
	timer.start()


func revealText(body,dialog):
	message = dialog
	set_bbcode(message[pag])
	timer = get_node("Timer")
	timer.set_wait_time(.05)
	timer.start()
	if get_visible_characters() > get_total_character_count():
		if pag < message.size() -1:
			pag +=1
			set_bbcode(message[pag])
			set_visible_characters(0)
