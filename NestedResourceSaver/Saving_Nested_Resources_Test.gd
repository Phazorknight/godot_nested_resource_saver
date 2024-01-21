extends Control

# Lables to display info
@onready var parent_resource_label: Label = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/PanelContainer/MarginContainer/ResourceInfo/HBoxContainer/ParentResource_Label
@onready var parent_resource_value_label: Label = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/PanelContainer/MarginContainer/ResourceInfo/HBoxContainer4/ParentResourceValue_Label
@onready var child_resource_label: Label = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/PanelContainer/MarginContainer/ResourceInfo/HBoxContainer2/ChildResource_Label
@onready var child_resource_value_label: Label = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/PanelContainer/MarginContainer/ResourceInfo/HBoxContainer3/ChildResourceValue_Label

@onready var button_parent_value_inc: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/HBoxContainer/Button_ParentValueInc
@onready var button_parent_value_dec: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/HBoxContainer/Button_ParentValueDec
@onready var button_child_value_inc: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/HBoxContainer2/Button_ChildValueInc
@onready var button_child_value_dec: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/HBoxContainer2/Button_ChildValueDec

@onready var button_set_child_resource_a: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/Button_SetChildResourceA
@onready var button_set_child_resource_b: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/Button_SetChildResourceB
@onready var button_set_parent_resource_a: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/Button_SetParentResourceA
@onready var button_set_parent_resource_b: Button = $MarginContainer/HBoxContainer/RightMarginContainer/VBoxContainer/Button_SetParentResourceB

@export var saved_test_resource : SavedTestResource

# Assigning parent resource here for test purposes.
@export var current_parent_resource : ParentResource

@export var button_parent_resource_a : ParentResource
@export var button_parent_resource_b : ParentResource
@export var button_child_resource_a : ChildResource
@export var button_child_resource_b : ChildResource



func _ready() -> void:
	# Connecting buttons to functions
	button_child_value_inc.pressed.connect(_on_increase_child_value_pressed)
	button_child_value_dec.pressed.connect(_on_decrease_child_value_pressed)
	button_parent_value_inc.pressed.connect(_on_increase_parent_value_pressed)
	button_parent_value_dec.pressed.connect(_on_decrease_parent_value_pressed)
	button_set_child_resource_a.pressed.connect(_on_set_child_resource_a_pressed)
	button_set_child_resource_b.pressed.connect(_on_set_child_resource_b_pressed)
	button_set_parent_resource_a.pressed.connect(_on_set_parent_resource_a_pressed)
	button_set_parent_resource_b.pressed.connect(_on_set_parent_resource_b_pressed)

	refresh_displayed_data()


func loading_save():
	# Check if save exists:
	if !saved_test_resource.save_exists():
		print("Saved test resource doesn't exist.")
		return
		
	saved_test_resource = saved_test_resource.load_save() as SavedTestResource
	
	# Emptying out the current resource:
	current_parent_resource = null
	
	# Applying the loaded data:
	print("Applying ", saved_test_resource.resource_to_save, " to ", current_parent_resource)
	print("Saved test resource value is: ", saved_test_resource.resource_to_save.value)
	current_parent_resource = saved_test_resource.resource_to_save
	
	
	print("Saved test resource loaded.")
	# Updating all displayed data now that the test_parent_resource has changed:
	refresh_displayed_data()


func saving_save():
	if !saved_test_resource:
		print("State doesn't exist. Creating...")
		saved_test_resource = SavedTestResource.new()
		
	# Writing the test_parent_resource to the saved_test_resource
	saved_test_resource.resource_to_save = current_parent_resource
	saved_test_resource.write_save()


func _on_button_save_pressed() -> void:
	saving_save()


func _on_button_load_pressed() -> void:
	loading_save()


func _on_increase_child_value_pressed():
	if current_parent_resource.child_resource:
		current_parent_resource.child_resource.add_to_value(1)
	refresh_displayed_data()
	
func _on_decrease_child_value_pressed():
	if current_parent_resource.child_resource:
		current_parent_resource.child_resource.add_to_value(-1)
	refresh_displayed_data()
		

func _on_increase_parent_value_pressed():
	if current_parent_resource:
		current_parent_resource.add_to_value(1)
	refresh_displayed_data()
	
func _on_decrease_parent_value_pressed():
	if current_parent_resource:
		current_parent_resource.add_to_value(-1)
	refresh_displayed_data()


func _on_set_child_resource_a_pressed():
	current_parent_resource.child_resource = button_child_resource_a
	refresh_displayed_data()
	
func _on_set_child_resource_b_pressed():
	current_parent_resource.child_resource = button_child_resource_b
	refresh_displayed_data()

func _on_set_parent_resource_a_pressed():
	current_parent_resource = button_parent_resource_a
	refresh_displayed_data()
	
func _on_set_parent_resource_b_pressed():
	current_parent_resource = button_parent_resource_b
	refresh_displayed_data()


func refresh_displayed_data():
	parent_resource_label.text = current_parent_resource.name
	parent_resource_value_label.text = str(current_parent_resource.value)
	if current_parent_resource.child_resource:
		child_resource_label.text = current_parent_resource.child_resource.name
		child_resource_value_label.text = str(current_parent_resource.child_resource.value)
	else:
		print("Child resource was null")
