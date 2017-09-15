extends Control

onready var close_button = get_node('container/Instant/Button')
onready var name_node = get_node('container/Button')
onready var cost_node = get_node('container/Cost')
onready var fan_node = get_node('container/Fans %')
onready var sell_node = get_node('container/Sells %')

func _ready():
  close_button.connect('pressed', self, 'queue_free')

func get_data():
  var data = {
    'type': 'instant',
    'button': name_node.get_value()
  }

  if cost_node.get_value() != null:
    data['cost'] = cost_node.get_value()

  if fan_node.get_value() != null:
    data['fan'] = fan_node.get_value()

  if sell_node.get_value() != null:
    data['sell'] = sell_node.get_value()

  return data

func try_to_set(data, node, item):
  var value = null
  
  if data.has(item):
    value = data[item]

  node.set_value(value)

func set_data(data):
  name_node.set_value(data.button)

  try_to_set(data, cost_node, 'cost')
  try_to_set(data, fan_node, 'fan')
  try_to_set(data, sell_node, 'sell')
