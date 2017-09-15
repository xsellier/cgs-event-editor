extends Control

const TARGETTED_AUDIENCE = ['young', 'all', 'mature']

var status = false

onready var checkbox_node = get_node('activate')

func _ready():
  checkbox_node.connect('toggled', self, 'toggle_checkbox')

func toggle_checkbox(status):
  self.status = status

func get_value():
  var value = null
  
  if checkbox_node.is_pressed():
    value = TARGETTED_AUDIENCE

  return value

func set_value(raw_value):
  var valid = raw_value != null

  checkbox_node.set_pressed(valid)
  toggle_checkbox(valid)
