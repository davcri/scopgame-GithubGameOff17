extends KinematicBody2D
# ci serve per accedere allo sprite e fargli fare il flip (es girare a dx se
# si sta muovendo a destra) per accedervi dobbiamo essere sicuri che lo sprite
# sia stato già creato, "inizializzato" da godot, ecco perché lo
# utilizziamo nella func _ready
var sprite_node
# NB: se non introduciamo "last direction"(input_direction) non appena il
# giocatore rilascia left o right, il pg si ferma istantaneamente (perché alla
# fine del codice moltiplichiamo per la direzione (che in questo caso è
# nulla) , per risolvere distinguiamo tra "input_direction" e "direction" per
# dare un'animazione più "smooth" fluida xD
var input_direction = 0  # può essere 0, 1 (destra) o -1 (sinistra)
var input_inverted = false
var direction = 1

var speed = Vector2()  # es: 200 pixel per secondo (indipendente dalla direzione)
var velocity = Vector2()  # velocity è un VETTORE, dipende dalla velocità, dalla direzione e dal delta (tempo)

const MAX_SPEED = 442
const ACCELERATION = 2600  # 2600 pixel per secondo al secondo
const DECELERATION = 5000

const FALL_DAMAGE = 25  # damage taken when falling into the void

# jf "quanto in alto salta" forza opposta alla forza di gravità; nella maggior
# parte degli engine l'asse y è negativo in alto e positivo in basso
# orientato in modo da assecondare la forza di gravità. Ecco perché in
# func input è MENO JUMP_FORCE (l'asse x rimane invariato)
const JUMP_FORCE = 800
const GRAVITY = 2000
const MAX_FALL_SPEED = 1400

# limiteremo a 1 il numero di salti che può compiere il giocatore prima di
# ritoccare terra (già 2 sarebbero esagerati nel nostro caso)
var jump_count = 0
var jump_pos = Vector2()  # posizione al momento del salto

# rendendola una var anziché const si potrebbe, più avanti nel gioco, con
# qualche upgrade potenziarla, in questo caso non ci interessa
const MAX_JUMP_COUNT = 1

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	# va inserito il path, essendo child diretto basta "Sprite"
	sprite_node = get_node("Sprite")
	jump_pos = get_pos()


func _input(event):
	var jump_action = "jump"
	
	if input_inverted:
		jump_action = "move_down"
		
	
	if jump_count < MAX_JUMP_COUNT and event.is_action_pressed(jump_action) && floor(speed.y) == 0:
		speed.y = - JUMP_FORCE
		jump_count += 1
		jump_pos = get_pos()  # FIX


func _fixed_process(delta):
	input_direction = get_input_direction()

	# MOVEMENT
	if input_direction == -direction:
		speed.x /= 3  # in modo da diminuire velocità se cambiamo direzione
	if input_direction:
		speed.x += ACCELERATION * delta
	else:
		speed.x -= DECELERATION * delta

	# Abbiamo sommato alla velocità attuale l'accelerazione per l'intervallo di
	# tempo (di frame, delta) in modo da accelerare solo per quegli istanti di
	# tempo, ottenendo un'animazione più fluida e veritiera. Ora come ora però la
	# nostra speed può aumentare a dismisura!!!! dobbiamo stabilire un range:
	speed.x = clamp(speed.x, 0, MAX_SPEED)

	speed.y += GRAVITY * delta  # in modo da dare un'accelerazione al nostro pg anche lungo l'asse y
	if speed.y > MAX_FALL_SPEED:
		speed.y = MAX_FALL_SPEED  # abbiamo limitato la velocità in caduta

	# direction anziché input direction (non vogliamo che sia 0) ora abbiamo
	# tutto, dobbiamo solo far muovere il pg lungo il nostro vettore velocità
	# (che ovviamente ha x = velocity;  y = 0 ) ( la componente y dipenderà dal
	# salto )
	velocity = Vector2(speed.x * delta * direction, speed.y * delta)

	# dobbiamo poi aggiungere un collision e poi il ground o il nostro pg
	# continua a cadere infinitamente; nei platform è altamente raccomandato
	# utilizzare collision rettangolari o quadrati, il nostro, shape è quadrato
	# altro consiglio utile, l'hitbox farla leggermente più piccola del pg

	# Problema, il pg, a meno di salti, rimane "ancorato" al ground, questo perché
	# dopo una collisione la posizione è ripristinata (di nascosto all'occhio umano)
	# tangente all'oggetto "colleso"; dobbiamo permettere al nostro eroe di
	# camminare, a tal scopo è utile ricordare il vettore velocità precedente alla
	# collisione:
	var movement_reminder = move(velocity)

	if is_colliding():
		# calcoliamo il vettore normale della collisione e ricordandoci della nostra
		# ultima direzione con slide costruiamo un movimento che escluda la collisione
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_reminder)
		# ovviamente non possiamo ignorarla totalmente, essendoci stata una collisione
		# dobbiamo resettare la speed lungo l'asse y che altrimenti si accumula
		# durante tutto il tempo della collisione col ground, possiamo scrivere
		# speed.y = 0; ma per collisioni con piani inclinati, e non perfettamente
		# orizzontali non è fisicamente coerente, meglio:
		speed = normal.slide(speed)
		move(final_movement)
		# dobbiamo ripristinare a 0 il jump_count ogni volta che il pg tocca terra
		# se non mettessimo la clausola if, saltando sui muri salterebbe all'infinito
		# se il vettore normale // asse y (0, +-1) allora si tratta del ground
		if normal == Vector2(0 , -1):
			jump_count = 0
	
	if is_falled():
		set_pos(jump_pos)
		var awareness_bar = get_node("../AwarenessBar")
		awareness_bar.decrease(FALL_DAMAGE)


func get_input_direction():
	# dobbiamo ascoltare se abbiamo input da parte del videogiocatore per far
	# reagire il player a suddetto input questa condizione qui sotto anziché fare
	# l'if potrei metterla sotto l'if di sotto, ma è molto meglio pensare all'organizzazione
	# del codice che non alle performance! quindi qui è la sezione:
	# INPUT
	var action_left = "move_left"
	var action_right = "move_right"
	var input_dir
	
	if input_inverted:
		action_left = "move_right" 
		action_right = "move_left"
		
	if input_direction:
		direction = input_direction  # in modo da avere solo -1 e 1 e non 0 che non passa l'if

	if Input.is_action_pressed(action_left):
		input_dir = -1
		sprite_node.set_flip_h(true) # true perché di default guarda a destra
	elif Input.is_action_pressed(action_right):
		input_dir = 1
		sprite_node.set_flip_h(false)
	else:
		input_dir = 0
		
	return input_dir


const FALL_POSITION = 1000

func is_falled():
	return get_pos().y > FALL_POSITION

func disable_input():
	set_fixed_process(false)
	# TODO Reset the level

func invert_right_and_left_input(active):
	print("INPUT INVERTED")
	
	if active:
		input_inverted = true
	else:
		input_inverted = false

# -----------------------------
# Methods for handling signals
# -----------------------------

func _on_AwarenessBar_low_awareness():
	print("LOW AWARENESS")
	invert_right_and_left_input(true)

func _on_AwarenessBar_zero_awareness():
	print("DEAD")
	disable_input()
