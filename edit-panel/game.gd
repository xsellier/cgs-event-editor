extends Control

const GAME_THEME = 'Adaptation de film'

var status = false

onready var checkbox_node = get_node('activate')
onready var name_node = get_node('value')

func _ready():
  checkbox_node.connect('toggled', self, 'toggle_checkbox')

func toggle_checkbox(status):
  self.status = status

func get_value():
  var value = null
  
  if checkbox_node.is_pressed():
    value = {
      'theme': GAME_THEME,
      'name': name_node.get_text()
    }

  return value

func set_value(raw_value):
  var valid = raw_value != null

  if valid:
    name_node.set_text(raw_value.name)

  checkbox_node.set_pressed(valid)
  toggle_checkbox(valid)
