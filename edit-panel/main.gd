extends Node

const UNIQ_SCENE = preload('res://edit-panel/uniq.scn')
const MULTIPLE_SCENE = preload('res://edit-panel/multiple.scn')

onready var event_id = null

onready var model = get_node('/root/model')
onready var event_model = model.get_model('event')

onready var controller = get_node('/root/controller')
onready var event_controller = controller.get_controller('event')

onready var name_node = get_node('margin/content/Common/Name')
onready var description_node = get_node('margin/content/Common/description')

onready var uniq_node = get_node('margin/content/Common/uniq/value')
onready var uniq_container_node = get_node('margin/content/UniqContainer')
onready var title_node = get_node('margin/content/Common/title')
onready var cancel_button = get_node('margin/content/controller/cancel')
onready var create_button = get_node('margin/content/controller/create')
onready var save_button = get_node('margin/content/controller/save')

func _ready():
  uniq_node.connect('toggled', self, 'toggle_uniq')
  cancel_button.connect('pressed', self, 'reset')
  create_button.connect('pressed', self, 'create')
  save_button.connect('pressed', self, 'save')

  title_node.set_text(get_name())

  event_model.connect('deleted_event', self, 'deleted_event')

  toggle_uniq(false)
  update_save_button()

func deleted_event(id):
  if event_id == id:
    reset()

func toggle_uniq(uniq):
  var sub_scene = null

  for child in uniq_container_node.get_children():
    uniq_container_node.remove_child(child)

  if uniq:
    sub_scene = UNIQ_SCENE.instance()
  else:
    sub_scene = MULTIPLE_SCENE.instance()
    
  uniq_container_node.add_child(sub_scene)

func update_save_button():
  save_button.set_disabled(event_id == null)

func reset():
  get_tree().reload_current_scene()
  event_id = null

  update_save_button()

func initialize(event_id=null):
  var event = event_model.get_event_by_id(event_id)

  name_node.set_value(event.name)
  description_node.set_value(event.description)
  self.event_id = event.id

  var uniq_node_value = (event.type == 'uniq')
    
  uniq_node.set_pressed(uniq_node_value)
  uniq_node.emit_signal('toggled', uniq_node_value)

  for child in uniq_container_node.get_children():
    child.initialize(event)

  update_save_button()

func fetch_event_data():
  var event = {
    'name': name_node.get_value(),
    'description': description_node.get_value(),
  }
  
  for node in uniq_container_node.get_children():
    var data = node.get_data()

    for key in data.keys():
      event[key] = data[key]
  
  return event

func save():
  var event = fetch_event_data()

  if event_id != null:
    event.id = event_id
    event_controller.edit_event(event)
  else:
    print('Not saved')

func create():
  var event = fetch_event_data()

  event_controller.create_event(event)
  update_save_button()
  reset()
