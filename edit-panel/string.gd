extends Control

onready var key_node = get_node('key')
onready var value_node = get_node('value')

func _ready():
  var key_name = get_name()

  key_node.set_text(key_name)

func get_value():
  return value_node.get_text()

func set_value(text):
  return value_node.set_text(text)