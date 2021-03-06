extends Control

onready var container = get_node('container')
onready var add_button_node = get_node('Action/add')
onready var action_node = get_node('Action')
onready var probability_node = get_node('Probability')

func _ready():
  add_button_node.connect('pressed', self, 'action_pressed')

  probability_node.set_boundaries(0.001, 0.1, 0.001, false)
  probability_node.force_value()

func action_pressed():
  var scene = action_node.get_scene()
  var scene_instance = scene.instance()

  container.add_child(scene_instance)

func get_data():
  var data = {
    'type': 'random',
    'probability': probability_node.get_value(),
    'actions': []
  }

  for child in container.get_children():
    data.actions.append(child.get_data())

  return data

func initialize(event):
  for child in container.get_children():
    container.remove_child(child)

    probability_node.set_value(event.probability)

  for action in event.actions:
    var scene = action_node.get_scene_by_type(action.type)
    var scene_instance = scene.instance()

    container.add_child(scene_instance)

    scene_instance.set_data(action)
