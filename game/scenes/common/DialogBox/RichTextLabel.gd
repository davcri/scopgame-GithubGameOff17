extends RichTextLabel

var message= [""]
var page = 0 
var timer

func _ready():
	set_visible_characters(0)

func _on_Timer_timeout():
	
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		if page < message.size() -1:
			page +=1
			set_bbcode(message[page])
			set_visible_characters(0)
	timer.start()


func revealText (body, dialog):
	message=dialog
	print(message[page])
	set_bbcode(message[page])
	print("sono il figlio")
	timer = get_node("Timer")
	timer.set_wait_time(.05)
	timer.start()
	if get_visible_characters() > get_total_character_count():
		if page < message.size() -1:
			page +=1
			set_bbcode(message[page])
			set_visible_characters(0)
