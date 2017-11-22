extends StreamPlayer


func _ready():
	self.set_volume(0.2)  # Halves volume
	self.play()
	

# length expected in seconds
func lower_volume(length):
	var tween_length = 2
	var tween = get_node("Tween")
	tween.interpolate_property(self, "stream/volume_db", get_volume_db(), get_volume_db() - 10, tween_length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "stream/volume_db", get_volume_db() - 10, get_volume_db(), tween_length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, length)
	tween.start()

func _on_DreamLordTrigger_DreamLordSpeaking(args):
	lower_volume(args[0])
