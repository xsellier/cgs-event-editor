extends Control

const ACTIONS = {
  'Instant': preload('res://edit-panel/instant.scn'),
  'Durable': preload('res://edit-panel/durable.scn')
}

onready var option_button_list = get_node('value')

func _ready():
  var index = 0
  
  for action in ACTIONS.keys():
    option_button_list.add_item(action, index)
    option_button_list.set_item_metadata(index, action)

    index += 1

func get_scene():
  var index = option_button_list.get_selected_ID()
  var key = option_button_list.get_item_metadata(index)

  return ACTIONS[key]

func get_scene_by_type(key):
  return ACTIONS[key.capitalize()]
