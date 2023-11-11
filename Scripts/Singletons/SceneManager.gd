extends Node
	
func change_scene(scene_name : String):
	GameManager.set_game_state(GameManager.GameState.Loading)
	await swipe_in()
	get_tree().change_scene_to_file(scene_name)
	swipe_out()
	GameManager.set_game_state(GameManager.GameState.Playing)

func swipe_in():
	$TransitionRect.visible = true
	$TransitionRect.position.x = get_viewport().size[0] * -1.1 
	while $TransitionRect.position.x < -1:
		$TransitionRect.position.x = lerp($TransitionRect.position.x, 0.0, 0.2)
		await get_tree().create_timer(0).timeout
	$TransitionRect.position.x = 0
	
func swipe_out():
	$TransitionRect.position.x = 0
	while $TransitionRect.position.x < get_viewport().size[0] * 1.1 - 1:
		$TransitionRect.position.x = lerp($TransitionRect.position.x, get_viewport().size[0] * 1.1 , 0.1)
		await get_tree().create_timer(0).timeout
	$TransitionRect.position.x = get_viewport().size[0] * 1.1 
	$TransitionRect.visible = false
