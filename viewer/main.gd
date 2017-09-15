extends Control

onready var event_id = null
onready var selected_index = null
onready var last_selected_node = null

onready var edition_buttons = get_node('margin/container/separator/middle/edition')
onready var create_panel_node = get_node('margin/container/separator/right/scrollCenter/center/CreatePanel')

onready var model = get_node('/root/model')
onready var event_model = model.get_model('event')

onready var random_event_list = get_node('margin/container/separator/left/Random/list')
onready var scheduled_event_list = get_node('margin/container/separator/left/Scheduled/list')

func _ready():
  get_tree().get_root().connect('size_changed', self, 'size_changed')

  random_event_list.set_select_mode(Tree.SELECT_SINGLE)
  scheduled_event_list.set_select_mode(Tree.SELECT_SINGLE)

  random_event_list.connect('item_selected', self, 'random_item_selected')
  scheduled_event_list.connect('item_selected', self, 'scheduled_item_selected')

  size_changed()

  event_model.connect('initialized', self, 'update_list')
  event_model.connect('new_event', self, 'update_list')
  event_model.connect('update_event', self, 'update_list')
  event_model.connect('deleted_event', self, 'update_list')

  edition_buttons.initialize(create_panel_node)
  update_list()

func random_item_selected(index):
  update_event_id(index, random_event_list)

func scheduled_item_selected(index):
  update_event_id(index, scheduled_event_list)

func update_event_id(index, selected_node):
  var metadata = selected_node.get_item_metadata(index)

  if last_selected_node != null:
    last_selected_node.unselect(selected_index)

  selected_index = index
  last_selected_node = selected_node

  if metadata != null and metadata.has('id'):
    event_id = metadata.id
  else:
    event_id = null

  edition_buttons.set_event_id(event_id)

func size_changed():
  self.set_size(get_viewport_rect().size)

func update_list(unused=null):
  var events = event_model.get_events()

  print('Updating event list ...')

  random_event_list.clear()
  scheduled_event_list.clear()

  for id in events.keys():
    var event = event_model.get_event_by_id(id)
    var metadata = {
      'id': event.id
    }
    var node = scheduled_event_list
    var text = ''

    if event.type == 'random':
      node = random_event_list
      text = '%s - %s - %s' % [event.name, event.actions.size(), event.type]

    elif event.type == 'scheduled':
      text = '%s - %s - %s' % [event.name, event.actions.size(), event.type]

    else:
      text = '%s - %s - %s' % [event.name, 1, event.type]

    var index = node.get_item_count()

    node.add_item(text)
    node.set_item_metadata(index, metadata)

  event_id = null
  edition_buttons.set_event_id(event_id)