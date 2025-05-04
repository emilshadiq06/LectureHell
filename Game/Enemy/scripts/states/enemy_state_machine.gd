class_name EnemyStateMachine extends Node
var states: Array = [ Enemy_State ]
var prev_state : Enemy_State
var current_state : Enemy_State
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState(current_state.Process(delta))
	pass

func _physics_process(delta: float) -> void:
	ChangeState(current_state.Physics(delta))
	pass

func _unhandled_input(event) -> void:
	ChangeState(current_state.HandleInput(event))
	pass
	
func initialize(_enemy:Enemy)->void:
	states = []  
	for c in get_children():
		if c is Enemy_State:
			states.append(c)
	
	if states.size()>0:
		states[0].enemy = _enemy
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState(new_state:Enemy_State)-> void:
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state.Exit()
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
