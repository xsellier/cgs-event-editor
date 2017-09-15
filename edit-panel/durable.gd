extends Control

onready var name_node = get_node('container/Button')
onready var duration_node = get_node('container/Duration')
onready var productivity_node = get_node('container/Productivity %')
onready var close_button = get_node('container/Durable/Button')

func _ready():
  duration_node.set_boundaries(1, 52, 1)
  duration_node.force_value()

  close_button.connect('pressed', self, 'queue_free')

func get_data():
  var data = {
    'type': 'durable',
    'button': name_node.get_value(),
    'duration': duration_node.get_value()
  }

  if productivity_node.get_value():
    data['productivity'] = productivity_node.get_value()

  return data

func set_data(data):
  name_node.set_value(data.button)
  duration_node.set_value(data.duration)

  var productivity = null

  if data.has('productivity'):
    productivity = data.productivity

  productivity_node.set_value(productivity)
