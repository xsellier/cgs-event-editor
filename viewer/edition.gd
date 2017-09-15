extends Control

onready var edit_panel = null

onready var event_id = null
onready var edit_button = get_node('list/Edit')
onready var delete_button = get_node('list/Delete')

onready var controller = get_node('/root/controller')
onready var event_controller = controller.get_controller('event')

func _ready():
  update_buttons()

  edit_button.connect('pressed', self, 'edit')
  delete_button.connect('pressed', self, 'delete')

func initialize(edit_panel):
  self.edit_panel = edit_panel

func delete():
  event_controller.delete_event(event_id)

func edit():
  if edit_panel != null:
    edit_panel.initialize(event_id)

func update_buttons():
  var status = event_id == null

  edit_button.set_disabled(status)
  delete_button.set_disabled(status)

func set_event_id(event_id):
  self.event_id = event_id

  update_buttons()
