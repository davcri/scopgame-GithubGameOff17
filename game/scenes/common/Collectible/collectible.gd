extends Node2D

# Collectible's value, for example, small coll. = 1, big coll. = 5
export var value = 1

func _ready():
	# owner è il root node; se è se stesso vale null, se è un altro nodo ci darà 
	# quell'altro nodo; in sostanza vogliamo che ci dia il nodo World (root)
	# al quale abbiamo messo uno script che tiene conto dei collezionabili
	# totali e quelli raccolti dal giocatore
	if get_owner() != null:
		get_owner().collectible_total += value
		get_owner().get_node("AwarenessBar/Collectibles_Total").set_text(
				" Total Scoppol : " + str(get_owner().collectible_total))


# abbiamo colleganto il segnale body_enter di Area2D del collezionabile
# che manda un segnale quando il player collide con un collezionabile
# e messo la seguente function _take_collectible legata al segnale
# volendo si poteva collegare con la gui, in "nodo" affianco a "ispector"
func _take_collectible( body ):
	if get_node("AnimationPlayer").get_current_animation() != "take_collectible":
		# abbiamo colliso, quindi incrementiamo il numero di collezionabili raccolti
		if get_owner() != null:
			get_owner().collectible_collected += value
			# Aggiorniamo la label delle scoppole prese
			get_owner().get_node("AwarenessBar/Collectibles_Collected").set_text(
			"Scoppol Count : " + str(get_owner().collectible_collected))
		# attiviamo l'animazione per far perdere opacità ai collezionabili
		get_node("AnimationPlayer").play("take_collectible")
		# bellissima funzione! fa scomparire la scoppola quando si collide
		# ALERT! va usata DOPO aver incrementato il valore di collezionabbbbbili
		#queue_free()

