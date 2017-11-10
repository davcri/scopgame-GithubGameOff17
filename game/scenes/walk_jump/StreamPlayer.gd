extends StreamPlayer


func _ready():
	self.set_volume(0.5)  # Halves volume
	self.play()
	



# voice_duration expected in seconds
func _on_DreamLordTrigger_DreamLordSpeaking(voice_duration):
	print(voice_duration)
	var tween_length = 2
	var tween = self.get_node("VolumeTween")
	tween.interpolate_property(self, "stream/volume_db", get_volume_db(), get_volume_db() - 10, tween_length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "stream/volume_db", get_volume_db(), get_volume_db() + 10, tween_length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, voice_duration)
	tween.start()