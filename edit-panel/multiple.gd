extends Node

onready var type_option_node = get_node('type/value')
onready var type_node = get_node('type')
onready var content_node = get_node('content')

func _ready():
  type_option_node.connect('item_selected', self, 'type_selected')

  type_selected()

func type_selected(id=null):
  for child in content_node.get_children():
    content_node.remove_child(child)

  var scene = type_node.get_type_scene()
  var scene_instance = scene.instance()

  content_node.add_child(scene_instance)

func get_data():
  return content_node.get_children()[0].get_data()

func initialize(event):
  type_node.set_type_scene(event.type)

  for child in content_node.get_children():
    child.initialize(event)
