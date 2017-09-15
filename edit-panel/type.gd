extends Control

const TYPES = {
  'Scheduled': preload('res://edit-panel/scheduled.scn'),
  'Random': preload('res://edit-panel/random.scn')
}

onready var option_button_list = get_node('value')

func _ready():
  var index = 0

  for type in TYPES.keys():
    option_button_list.add_item(type, index)
    option_button_list.set_item_metadata(index, type)

    index += 1

func get_type_scene():
  var index = option_button_list.get_selected_ID()
  var key = option_button_list.get_item_metadata(index)

  return TYPES[key]

func set_type_scene(type):
  var selected_index = 0

  for index in range(0, option_button_list.get_item_count()):
    var metadata = option_button_list.get_item_metadata(index)
    
    if type.capitalize() == metadata:
      selected_index = index

  option_button_list.select(selected_index)
  option_button_list.emit_signal('item_selected', selected_index)
