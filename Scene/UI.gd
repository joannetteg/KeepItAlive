extends Control

const MAX_VALUE = 48
const MAX_LIFE = 100
const MAX_HAPPINESS = 100

var gameTimer = 0

var currentThirstValue = 0
var currentHungerValue = 0
var currentToiletValue = 0
var currentTeachValue = 0
var currentPetValue = 0
var currentPlayValue = 0

var fast = 6
var medium = 4
var slow = 2

var canTakeAction
var currentLife = MAX_LIFE
var currentHappiness = MAX_HAPPINESS

var stage1 = false
var stage2 = false
var stage3 = false
var stage4 = false
var stage5 = false
var stage6 = false

enum gameStates{
	menu,
	stage1,
	stage2,
	stage3,
	stage4,
	stage5,
	stage6,
	dead
}

var gameState = gameStates.menu
var on_Cooldown = false

onready var bar_Thirst = get_node("Background/BAR_Thirst")
onready var bar_Hunger = get_node("Background/BAR_Hunger")
onready var bar_Toilet = get_node("Background/BAR_Toilet")
onready var bar_Teach = get_node("Background/BAR_Teach")
onready var bar_Pet = get_node("Background/BAR_Pet")
onready var bar_Play = get_node("Background/BAR_Play")

onready var bar_Life = get_node("Background/BAR_Life")
onready var bar_Happy = get_node("Background/BAR_Happy")
onready var bar_Life_Progress = get_node("Background/BAR_Life/Progress")
onready var bar_Happy_Progress = get_node("Background/BAR_Happy/Progress")
onready var bar_Life_ICN = get_node("Background/BAR_Life/ICN")
onready var bar_Happy_ICN = get_node("Background/BAR_Happy/ICN")

onready var btn_Thirst = get_node("Background/BTN_Thirst")
onready var btn_Hunger = get_node("Background/BTN_Hunger")
onready var btn_Toilet = get_node("Background/BTN_Toilet")
onready var btn_Teach = get_node("Background/BTN_Teach")
onready var btn_Pet = get_node("Background/BTN_Pet")
onready var btn_Play = get_node("Background/BTN_Play")
onready var btn_Start_Game = get_node("Background/PlayButton")

onready var stages_Timer = get_node("../StagesUnlock")
onready var cooldown_Timer = get_node("../Cooldown")
onready var spr_Kitty = get_node("Kitty")
onready var uiAnimation = get_node("../UIAnimation")

# Called when the node enters the scene tree for the first time.
func _ready():
	gameState = gameStates.menu

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(stages_Timer.time_left)
	
	if gameState == gameStates.menu:
		spr_Kitty.visible = false
		bar_Life.visible = false
		bar_Happy.visible = false
		
	elif gameState == gameStates.stage1:
		_init_stage1()
		if stages_Timer.time_left < 50:
			gameState = gameStates.stage2
			
	elif gameState == gameStates.stage2:
		_init_stage2()
		if stages_Timer.time_left < 40:
			gameState = gameStates.stage3
			
	elif gameState == gameStates.stage3:
		_init_stage3()
		if stages_Timer.time_left < 30:
			gameState = gameStates.stage4
		
	elif gameState == gameStates.stage4:
		_init_stage4()
		if stages_Timer.time_left < 20:
			gameState = gameStates.stage5
		
	elif gameState == gameStates.stage5:
		_init_stage5()
		if stages_Timer.time_left < 10:
			gameState = gameStates.stage6
		
	elif gameState == gameStates.stage6:
		_init_stage6()
		
	elif gameState == gameStates.dead:
		_on_Cooldown()
		
	if stage1:
		currentThirstValue -= 1 * (delta * fast)
		gameTimer += (1 * delta)
		#print(round(gameTimer))
		
	if stage2:
		currentHungerValue -= 1 * (delta * medium)
		
	if stage3:
		currentToiletValue -= 1 * (delta * medium)
		
	if stage4:
		currentTeachValue -= 1 * (delta * slow)
		
	if stage5:
		currentPetValue -= 1 * (delta * fast)
		
	if stage6:
		currentPlayValue -= 1 * (delta * medium)
	
	if (currentThirstValue <= 0 && stage1) || (currentHungerValue <= 0 && stage2) || (currentToiletValue <= 0 && stage3):
		currentLife -= 1 * (delta * medium)
		
	if (currentPetValue <= 0 && stage5) || (currentPlayValue <= 0 && stage6):
		currentHappiness -= 1 * (delta * medium)
		
	_update_Bars()
	
	if currentTeachValue <= 0 && stage4:
		print("Kitty ran away and never came back !")
		gameState = gameStates.dead
		
	if currentLife <= 0:
		print("You didn't keep Kitty alive !")
		gameState = gameStates.dead
		
	if currentHappiness <= 0:
		print("Kitty ran away and never came back !")
		gameState = gameStates.dead
		
func _update_Bars():
	bar_Thirst.value = currentThirstValue
	bar_Hunger.value = currentHungerValue
	bar_Toilet.value = currentToiletValue
	bar_Teach.value = currentTeachValue
	bar_Pet.value = currentPetValue
	bar_Play.value = currentPlayValue
	
	bar_Life_Progress.value = currentLife
	bar_Happy_Progress.value = currentHappiness
		
func _on_Cooldown():
	on_Cooldown = true
	cooldown_Timer.start()
	btn_Thirst.disabled = true
	btn_Hunger.disabled = true
	btn_Toilet.disabled = true
	btn_Teach.disabled = true
	btn_Pet.disabled = true
	btn_Play.disabled = true
	
func _off_Cooldown():
	on_Cooldown = false
	cooldown_Timer.stop()
	if stage1 == true: btn_Thirst.disabled = false
	if stage2 == true: btn_Hunger.disabled = false
	if stage3 == true: btn_Toilet.disabled = false
	if stage4 == true: btn_Teach.disabled = false
	if stage5 == true: btn_Pet.disabled = false
	if stage6 == true: btn_Play.disabled = false
	
func _init_stage1():
	if !stage1:
		stage1 = true
		currentThirstValue = MAX_VALUE
		btn_Thirst.disabled = false
	
func _init_stage2():
	if !stage2:
		stage2 = true
		currentHungerValue = MAX_VALUE
		if !on_Cooldown: btn_Hunger.disabled = false
	
func _init_stage3():
	if !stage3:
		stage3 = true
		currentToiletValue = MAX_VALUE
		if !on_Cooldown: btn_Toilet.disabled = false
	
func _init_stage4():
	if !stage4:
		stage4 = true
		currentTeachValue = MAX_VALUE
		if !on_Cooldown: btn_Teach.disabled = false
	
func _init_stage5():
	if !stage5:
		stage5 = true
		currentPetValue = MAX_VALUE
		if !on_Cooldown: btn_Pet.disabled = false
	
func _init_stage6():
	if !stage6:
		stage6 = true
		currentPlayValue = MAX_VALUE
		if !on_Cooldown: btn_Play.disabled = false

# Event Listeners
func _on_BTN_Play_pressed():
	currentPlayValue = MAX_VALUE
	cooldown_Timer.set("wait_time", 2)
	_on_Cooldown()

func _on_BTN_Pet_pressed():
	currentPetValue = MAX_VALUE
	cooldown_Timer.set("wait_time", 2)
	_on_Cooldown()

func _on_BTN_Teach_pressed():
	currentTeachValue = MAX_VALUE
	cooldown_Timer.set("wait_time", 2)
	_on_Cooldown()

func _on_BTN_Toilet_pressed():
	currentToiletValue = MAX_VALUE
	cooldown_Timer.set("wait_time", 2)
	_on_Cooldown()

func _on_BTN_Hunger_pressed():
	currentHungerValue = MAX_VALUE
	cooldown_Timer.set("wait_time", 2)
	_on_Cooldown()

func _on_BTN_Thirst_pressed():
	currentThirstValue = MAX_VALUE
	cooldown_Timer.set("wait_time", 2)
	_on_Cooldown()

func _on_PlayButton_pressed():
	stages_Timer.start()
	
	spr_Kitty.visible = true
	bar_Life.visible = true
	bar_Happy.visible = true
	btn_Start_Game.disabled = true
	btn_Start_Game.visible = false
	
	gameState = gameStates.stage1

func _on_Cooldown_timeout():
	_off_Cooldown()
