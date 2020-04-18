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

onready var bar_Thirst = get_node("Background/BAR_Thirst")
onready var bar_Hunger = get_node("Background/BAR_Hunger")
onready var bar_Toilet = get_node("Background/BAR_Toilet")
onready var bar_Teach = get_node("Background/BAR_Teach")
onready var bar_Pet = get_node("Background/BAR_Pet")
onready var bar_Play = get_node("Background/BAR_Play")

onready var btn_Thirst = get_node("Background/BTN_Thirst")
onready var btn_Hunger = get_node("Background/BTN_Hunger")
onready var btn_Toilet = get_node("Background/BTN_Toilet")
onready var btn_Teach = get_node("Background/BTN_Teach")
onready var btn_Pet = get_node("Background/BTN_Pet")
onready var btn_Play = get_node("Background/BTN_Play")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
