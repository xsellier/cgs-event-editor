extends Node

const uuid_utils = preload('res://utils/uuid.gd')

signal new_event
signal update_event
signal deleted_event
signal initialized

onready var data = {}

func initialize(events={}):
  self.data = events

  emit_signal('initialized')

func get_events():
  return self.data

func create_event(event):
  var id = uuid_utils.v4()

  event.id = id
  self.data[id] = event

  emit_signal('new_event', event)

  return id


func edit_event(event):
  self.data[event.id] = event

  emit_signal('update_event', event)

  return event.id

func delete_event(id):
  var events = get_events()

  if events.has(id):
    events.erase(id)

    emit_signal('deleted_event', id)

  return id

func get_event_by_id(id):
  var events = get_events()
  var event = null

  if id != null and events.has(id):
    event = events[id]

  return event
