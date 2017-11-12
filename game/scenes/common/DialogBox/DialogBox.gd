#DialogBox
extends RichTextLabel

# class member variables go here, for example:

var dialog = ["Steam's saves are coming", "you must buy"]
var page = 0 
var timer
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_bbcode(dialog[page])
	set_visible_characters(0)

func _on_Timer_timeout():
	
	set_visible_characters(get_visible_characters()+1);



func _on_DreamLordTrigger_body_enter( body ):
	if body.get_name() == "Player":
		timer = Timer.new()
		timer.set_wait_time(.05)
		timer.connect("timeout",self,"_on_Timer_timeout") 
		add_child(timer) #to process
		timer.start()
	if get_visible_characters() > get_total_character_count():
		if page < dialog.size() -1:
			page +=1
			set_bbcode(dialog[page])
			set_visible_characters(0)
