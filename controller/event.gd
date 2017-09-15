extends Control

onready var model = get_node('/root/model')
onready var file_model = model.get_model('file')
onready var event_model = model.get_model('event')

func import_file(path):
  var events = file_model.read(path)
  
  event_model.initialize(events)

func export_file(path):
  var events = event_model.get_events()

  file_model.save(path, events)

func create_event(event):
  return event_model.create_event(event)

func edit_event(event):
  return event_model.edit_event(event)

func delete_event(id):
  return event_model.delete_event(id)
