extends Control

onready var description_node = get_node('value')

func get_value():
  return description_node.get_text()

func set_value(text):
  return description_node.set_text(text)