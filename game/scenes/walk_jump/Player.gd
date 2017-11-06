extends KinematicBody2D

#NB: se non introduciamo "last direction"(input_direction) non appena il giocatore rilascia left o right, il pg si ferma istantaneamente (perché alla fine
#del codice moltiplichiamo per la direzione (che in questo caso è nulla) , per risolvere distinguiamo tra "input_direction" e "direction" per dare 
#un'animazione più "smooth" fluida xD
var input_direction = 0		#può essere 0, 1 (destra) o -1 (sinistra)
var direction = 0

var speed_x = 0		#es: 200 pixel per secondo (indipendente dalla direzione
var speed_y = 0
var velocity = Vector2()		#velocity è un VETTORE, dipende dalla velocità, dalla direzione e dal delta (tempo)

const MAX_SPEED = 600
const ACCELERATION = 1000		#1000 pixel per secondo al secondo
const DECELERATION = 2000

#jf "quanto in alto salta" forza opposta alla forza di gravità; nella maggior parte degli engine l'asse y è negativo in alto e positivo in basso
#orientato in modo da assecondare la forza di gravità. Ecco perché in func input è MENO JUMP_FORCE (l'asse x rimane invariato)
const JUMP_FORCE = 800
const GRAVITY = 2000

func _ready():
	set_process(true)
	set_process_input(true)


func _input(event):
	if event.is_action_pressed("jump"):
		speed_y = - JUMP_FORCE


func _process(delta):
	#dobbiamo ascoltare se abbiamo input da parte del videogiocatore per far reagire il player a suddetto input
	#questa condizione qui sotto anziché fare l'if potrei metterla sotto l'if di sotto, ma è molto meglio pensare all'organizzazione
	#del codice che non alle performance! quindi qui è la sezione:
	# INPUT
	if input_direction:
		direction = input_direction		## in modo da avere solo -1 e 1 e non 0 che non passa l'if
	
	if Input.is_action_pressed("move_left"):
		input_direction = -1
	elif Input.is_action_pressed("move_right"):
		input_direction = 1
	else:
		input_direction = 0
	
	#qui la sezione:
	#MOVEMENT
	if input_direction == -direction:
		speed_x /= 3		#in modo da diminuire velocità se cambiamo direzione
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECELERATION * delta
	
	#Abbiamo sommato alla velocità attuale l'accelerazione per l'intervallo di tempo (di frame, delta)
	#in modo da accelerare solo per quegli istanti di tempo, ottenendo un'animazione più fluida e veritiera.
	#Ora come ora però la nostra speed può aumentare a dismisura!!!! dobbiamo stabilire un range:
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	speed_y += GRAVITY * delta 		#in modo da dare un'accelerazione al nostro pg anche lungo l'asse y
	
	#direction anziché input direction (non vogliamo che sia 0)
	#ora abbiamo tutto, dobbiamo solo far muovere il pg lungo il nostro vettore velocità (che ovviamente ha x = velocity;  y = 0 )
	#( la componente y dipenderà dal salto )
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	
	move(velocity)
	
	#dobbiamo poi aggiungere un collision e poi il ground o il nostro pg continua a cadere infinitamente;
	#nei platform è altamente raccomandato utilizzare collision rettangolari o quadrati, il nostro, shape è quadrato
	#altro consiglio utile, l'hitbox farla leggermente più piccola del pg