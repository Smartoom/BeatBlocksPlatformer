extends Area2D

@onready var interact_prompt := $InteractionPrompt

func _process(_delta: float) -> void:
	interact_prompt.visible = false
	for ob in listOfPossibleInteractibles:
		if ob.can_interact:
			interact_prompt.visible = true
			break
	
	if Input.is_action_just_pressed("Down") and listOfPossibleInteractibles.size() > 0 and listOfPossibleInteractibles.get(0).can_interact:
		listOfPossibleInteractibles.get(0).interact()

var listOfPossibleInteractibles := []
func _on_area_entered(area: Area2D) -> void:
	listOfPossibleInteractibles.append(area)


func _on_area_exited(area: Area2D) -> void:
	listOfPossibleInteractibles.erase(area)
