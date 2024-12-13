extends Node

@onready var sound_effect: Node = $SoundEffect
@onready var bgm_player: AudioStreamPlayer = $StartBGM
@onready var story_player: AudioStreamPlayer = $StoryAudio
@onready var sfx: Node = $SFX

var has_stop_all_called: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Play sound effect? who add this
func play_sound_effect(name: String) -> void:
	var player := sound_effect.get_node(name) as AudioStreamPlayer
	if not player:
		return
	player.play()


# Play bgm for the whole game
func play_bgm(stream: AudioStream) -> void:
	if bgm_player.stream == stream and bgm_player.playing:
		return
	bgm_player.stream = stream
	bgm_player.play()


# Play all the sound effect
func play_sfx(name: String) -> void:
	var player := sfx.get_node(name) as AudioStreamPlayer
	if not player:
		return
	player.play()


# Play the background story audio
func play_story(stream: AudioStream) -> void:
	if story_player.stream == stream and story_player.playing:
		return
	story_player.stream = stream
	story_player.play()


# Stop the audio smoothly
func stop_audio_smooth(player: AudioStreamPlayer, fade_out_duration: float = 1.0) -> void:
	if player and player.playing:
		var tween = create_tween()
		tween.tween_property(player, "volume_db", -80, fade_out_duration)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		_on_tween_completed(player)


func _on_tween_completed(player: AudioStreamPlayer) -> void:
	player.stop()


# Stop the start bgm
func stop_start() -> void:
	stop_audio_smooth($SFX/StartBGM)

# Stop the story voice
func stop_story() -> void:
	stop_audio_smooth($SFX/StoryAudio)


# A function shows that the audio is finished
func play_finish(player: AudioStreamPlayer, stream: AudioStream) -> void:
	if player:
		await player.finished
	else:
		var audio_stream = stream
		var duration = get_audio_duration(audio_stream)
		await get_tree().create_timer(duration).timeout


# Get the duration of the audio
func get_audio_duration(audio_stream: AudioStream) -> float:
	if audio_stream is AudioStream:
		return audio_stream.get_length()
	elif audio_stream is AudioStreamMP3:
		return audio_stream.get_length()
	return 0.0

func stop_all() -> void:
	if has_stop_all_called:
		return
		
	var fade_out_duration: float = 1.0

	# Stop bgm_player and story_player
	if bgm_player and bgm_player.playing:
		stop_audio_smooth(bgm_player, fade_out_duration)
	
	if story_player and story_player.playing:
		stop_audio_smooth(story_player, fade_out_duration)
	
	# Stop sound_effect AudioStreamPlayer
	for child in sound_effect.get_children():
		if child is AudioStreamPlayer and child.playing:
			stop_audio_smooth(child, fade_out_duration)
	
	# Stop SFX AudioStreamPlayer
	for child in sfx.get_children():
		if child is AudioStreamPlayer and child.playing:
			stop_audio_smooth(child, fade_out_duration)
