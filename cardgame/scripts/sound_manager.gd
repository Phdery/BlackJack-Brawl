extends Node

@onready var sound_effect: Node = $SoundEffect
@onready var bgm_player: AudioStreamPlayer = $StartBGM
@onready var story_player: AudioStreamPlayer = $StoryAudio
@onready var sfx: Node = $SFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sound_effect(name: String) -> void:
	var player := sound_effect.get_node(name) as AudioStreamPlayer
	if not player:
		return
	player.play()

func play_bgm(stream: AudioStream) -> void:
	if bgm_player.stream == stream and bgm_player.playing:
		return
	bgm_player.stream = stream
	bgm_player.play()

func play_sfx(name: String) -> void:
	var player := sfx.get_node(name) as AudioStreamPlayer
	if not player:
		return
	player.play()

func play_story(stream: AudioStream) -> void:
	if story_player.stream == stream and story_player.playing:
		return
	story_player.stream = stream
	story_player.play()
	
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
	
	
func stop_all_sfx() -> void:
	for child in sfx.get_children():
		if child is AudioStreamPlayer:
			stop_audio_smooth(child)
