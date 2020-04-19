extends Control

const MAX_VALUE = 48
const MAX_LIFE = 100
const MAX_HAPPINESS = 100

var currentThirstValue = 0
var currentHungerValue = 0
var currentToiletValue = 0
var currentTeachValue = 0
var currentPetValue = 0
var currentPlayValue = 0

var canTakeAction
var currentLife = 0
var currentHappiness = 0

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

onready var stages_Timer = get_node("../StagesUnlock")
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
		btn_Thirst.disabled = false
		if stages_Timer.time_left < 50:
			gameState = gameStates.stage2
			
	elif gameState == gameStates.stage2:
		btn_Hunger.disabled = false
		if stages_Timer.time_left < 40:
			gameState = gameStates.stage3
			
	elif gameState == gameStates.stage3:
		btn_Toilet.disabled = false
		if stages_Timer.time_left < 30:
			gameState = gameStates.stage4
		
	elif gameState == gameStates.stage4:
		btn_Teach.disabled = false
		if stages_Timer.time_left < 20:
			gameState = gameStates.stage5
		
	elif gameState == gameStates.stage5:
		btn_Pet.disabled = false
		if stages_Timer.time_left < 10:
			gameState = gameStates.stage6
		
	elif gameState == gameStates.stage6:
		btn_Play.disabled = false
		
	elif gameState == gameStates.dead:
		_on_Cooldown()
		
func _on_Cooldown():
	btn_Thirst.disabled = true
	btn_Hunger.disabled = true
	btn_Toilet.disabled = true
	btn_Teach.disabled = true
	btn_Pet.disabled = true
	btn_Play.disabled = true

# Event Listeners
func _on_BTN_Play_pressed():
	currentPlayValue = MAX_VALUE

func _on_BTN_Pet_pressed():
	currentPetValue = MAX_VALUE

func _on_BTN_Teach_pressed():
	currentTeachValue = MAX_VALUE

func _on_BTN_Toilet_pressed():
	currentToiletValue = MAX_VALUE

func _on_BTN_Hunger_pressed():
	currentHungerValue = MAX_VALUE

func _on_BTN_Thirst_pressed():
	currentThirstValue = MAX_VALUE
