extends KinematicBody2D

# NB: se non introduciamo "last direction"(input_direction) non appena il
# giocatore rilascia left o right, il pg si ferma istantaneamente (perché alla
# fine del codice moltiplichiamo per la direzione (che in questo caso è
# nulla) , per risolvere distinguiamo tra "input_direction" e "direction" per
# dare un'animazione più "smooth" fluida xD
var input_direction = 0  # può essere 0, 1 (destra) o -1 (sinistra)
var direction = 0

var speed = Vector2()  # es: 200 pixel per secondo (indipendente dalla direzione)
var velocity = Vector2()  # velocity è un VETTORE, dipende dalla velocità, dalla direzione e dal delta (tempo)

const MAX_SPEED = 600
const ACCELERATION = 1000  # 1000 pixel per secondo al secondo
const DECELERATION = 2000

# jf "quanto in alto salta" forza opposta alla forza di gravità; nella maggior
# parte degli engine l'asse y è negativo in alto e positivo in basso
# orientato in modo da assecondare la forza di gravità. Ecco perché in
# func input è MENO JUMP_FORCE (l'asse x rimane invariato)
const JUMP_FORCE = 800
const GRAVITY = 2000

func _ready():
	set_process(true)
	set_process_input(true)


func _input(event):
	if event.is_action_pressed("jump"):
		speed.y = - JUMP_FORCE


func _process(delta):
	# dobbiamo ascoltare se abbiamo input da parte del videogiocatore per far
	# reagire il player a suddetto input questa condizione qui sotto anziché fare
	# l'if potrei metterla sotto l'if di sotto, ma è molto meglio pensare all'organizzazione
	# del codice che non alle performance! quindi qui è la sezione:
	# INPUT
	if input_direction:
		direction = input_direction		# in modo da avere solo -1 e 1 e non 0 che non passa l'if

	if Input.is_action_pressed("move_left"):
		input_direction = -1
	elif Input.is_action_pressed("move_right"):
		input_direction = 1
	else:
		input_direction = 0

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
