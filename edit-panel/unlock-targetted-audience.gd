extends Control

const TARGETTED_AUDIENCE = [{
  'name': 'young',
  'label': 'LABEL_TARGETTED_AUDIENCE_YOUNG'
},
{
  'name': 'all',
  'label': 'LABEL_TARGETTED_AUDIENCE_ALL'
},
{
  'name': 'mature',
  'label': 'LABEL_TARGETTED_AUDIENCE_MATURE'
}]

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
