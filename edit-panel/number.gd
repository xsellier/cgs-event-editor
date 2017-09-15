extends Control

onready var range_node = get_node('value')
onready var checkbox_node = get_node('activate')

func get_value():
  var value = null

  if checkbox_node.is_pressed():
    value = range_node.get_value()

  return value

func set_value(raw_value):
  var valid = raw_value != null
  var value = 0

  if valid:
    value = int(raw_value)

  checkbox_node.set_pressed(valid)
  range_node.set_value(value)
  