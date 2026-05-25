#**********************************#
# ███████╗ █████╗ ██╗  ██╗██╗  ██╗ #
# ██╔════╝██╔══██╗██║  ██║██║  ██║ #
# █████╗  ███████║███████║███████║ #
# ██╔══╝  ██╔══██║██╔══██║██╔══██║ #
# ██║     ██║  ██║██║  ██║██║  ██║ #
# ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ #
#**********************************#
# FrozenFried                      #
# Github - Frozen-Fried/fahh       #
#**********************************#

@tool
extends Node

@onready var stream_player: AudioStreamPlayer = $AudioStreamPlayer

var loop_stopper:bool = false
func _ready() -> void:
	
	stream_player.bus = "Master"
	stream_player.stream = load("res://addons/fahh/sounds/fahh/fahh_small.mp3")
func play_():
	if loop_stopper == false:
		stream_player.play()
		loop_stopper = true
