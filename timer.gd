extends Control

# TIMER COUNT
@onready var timer_count: Label = $Timer_count

var hours : int
var minutes : int
var seconds : int

var data : Dictionary = {
	"hours" : "00",
	"minutes" : "00",
	"seconds" : "00"
}


# TIMER PARAMETRES
@export_category("Timer Parametres")
@export var show_hours : bool = true
@export_range(0, 24, 1) var begin_hours : int
@export_range(0, 59, 1) var begin_minutes : int
@export_range(0, 59, 1) var begin_seconds : int


# TIMER DEBUG
@export_category("Timer Debug")
@export var on_debug : bool = true


# TIMER METHODS
func setDataTimer(new_data : Array) -> void:
	hours = new_data[0]
	minutes = new_data[1]
	seconds = new_data[2]

func clearDataTimer() -> void:
	hours   	= 0
	minutes 	= 0
	seconds 	= 0

func getDataTimer() -> Dictionary:
	return data


# TIMER BODY
func _ready() -> void:
	setDataTimer( [begin_hours,begin_minutes,begin_seconds] )
	if show_hours == true:
		timer_count.text = "00:00:00"
	else:
		timer_count.text = "00:00"

func _on_timer_timeout() -> void:
	if seconds < 59:
		seconds += 1
	else: 
		seconds = 0
		if minutes < 59:
			minutes += 1
		else: 
			minutes = 0
			hours += 1
		if hours < 23:
			hours += 1
		else:
			hours = 0

	if seconds < 10:
		data.set("seconds",("0" + str(seconds)))
	else:
		data.set("seconds",(str(seconds)))
	
	if minutes < 10:
		data.set("minutes",("0" + str(minutes)))
	else:
		data.set("minutes",(str(minutes)))
	
	if hours < 10:
		data.set("hours",("0" + str(hours)))
	else:
		data.set("hours",(str(hours)))
	
	if show_hours == true:
		timer_count.text = data["hours"] + ":" + data["minutes"] + ":" + data["seconds"]
	else:
		timer_count.text = data["minutes"] + ":" + data["seconds"]
	
	if on_debug == true:
		print(data)
