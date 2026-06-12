 # Developed by Natheniel.
extends CanvasLayer


@onready var title_label : Label = $CenterContainer/TitleLable

#---Title Set Function-----------------------------------------------------------------------
func set_title(text: String) -> void:
	title_label.text = text

#---Ready Function---------------------------------------------------------------------------
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
