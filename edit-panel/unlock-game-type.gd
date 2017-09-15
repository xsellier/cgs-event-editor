extends Control

const GAME_TYPES_LIST = ['gta-like',  'myst-like',  'rogue-like',  'moba-like']

var status = false

onready var option_node = get_node('value')
onready var checkbox_node = get_node('activate')

func _ready():
  checkbox_node.connect('toggled', self, 'toggle_checkbox')

  for game_type in GAME_TYPES_LIST:
    option_node.add_item(game_type)

func toggle_checkbox(status):
  self.status = status

func get_value():
  var value = null
  
  if checkbox_node.is_pressed():
    var index = option_node.get_selected()

    value = option_node.get_item_text(index)

  return value

func set_value(raw_value):
  var valid = raw_value != null
  var value = 0

  if valid:
    for index in range(0, option_node.get_item_count()):
      var item = option_node.get_item_text(index)

      if item == raw_value:
        value = index

  checkbox_node.set_pressed(valid)
  toggle_checkbox(valid)
  option_node.select(value)
