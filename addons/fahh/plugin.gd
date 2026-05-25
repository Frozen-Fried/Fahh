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

#NOTE:Hello, this is a really really messy plugin.
#I tried to pack everything in 2 files lol

@tool
extends EditorPlugin

var log_file_path
var poll_timer = Timer.new()
var IS_PLAYING:bool = false
var DO_NOT_DISTURB:bool = true

var FAHH_MID:AudioStream = load("res://addons/fahh/sounds/fahh/fahh_mid.mp3")
var FAHH_SMALL:AudioStream = load("res://addons/fahh/sounds/fahh/fahh_small.mp3")
var yelled:bool = false
func _ready() -> void:
	
	log_file_path = OS.get_user_data_dir()
#this doesn't work
#func _enable_plugin() -> void:
	#add_autoload_singleton("FahhPlayer","res://addons/fahh/autoload/fahh_player.tscn")
func _enter_tree() -> void:
	add_child(poll_timer)
	poll_timer.wait_time = 1.0
	poll_timer.one_shot = false
	poll_timer.autostart = false
	poll_timer.timeout.connect(read_log)
	set_process(true)
func _process(_delta: float) -> void:
	
	var is_currently_playing = EditorInterface.is_playing_scene()
	if is_currently_playing and !IS_PLAYING:
		IS_PLAYING = true
		print("started")
		FahhPlayer.loop_stopper = false
		poll_timer.start()
	elif !is_currently_playing and IS_PLAYING:
		IS_PLAYING = false
		print("stopped")
		poll_timer.stop()
func read_log():
	#NOTE:This is Windows only,but you can very easily make it for Linux
	if OS.get_name() == "Windows":
		var log_dir = OS.get_user_data_dir() + "/logs"
		var bat_path = ProjectSettings.globalize_path("res://addons/fahh/batch_file/read.bat")
		var args = ["/c",bat_path,log_dir]
		var output = []
		var exit_code = OS.execute("cmd.exe",args,output,true)
		if FileAccess.file_exists(str(log_dir+"/godot_fahh.txt")):
			var file_to_read = FileAccess.open(str(log_file_path + "/logs/godot_fahh.txt"),FileAccess.READ)
			var log = file_to_read.get_as_text()
			fahh(log)
	elif OS.get_name() == "Linux":
		pass
		###Your code goes here, check the read.bat to see what it does :)
func fahh(log:String):
	var error_count := log.count("SCRIPT ERROR:")
	print(error_count)
	FahhPlayer.play_()
