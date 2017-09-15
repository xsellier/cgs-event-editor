extends Control

onready var range_node = get_node('value')
onready var checkbox_node = get_node('activate')
onready var key_node = get_node('key')
onready var spinbox_value = get_node('key/SpinBox')

var status = false

func _ready():
  var key_name = get_name()

  key_node.set_text(key_name)
  checkbox_node.connect('toggled', self, 'toggle_checkbox')
  range_node.connect('value_changed', self, 'update_spinbox_value')

func toggle_checkbox(status):
  self.status = status

func update_spinbox_value(value):
  spinbox_value.set_text('%s' % value)

func set_boundaries(min_value, max_value, step_value, rounded=true):
  range_node.set_min(min_value)
  range_node.set_max(max_value)
  range_node.set_step(step_value)
  range_node.set_val(min_value)
  range_node.set_rounded_values(rounded)

func force_value():
  checkbox_node.set_disabled(true)
  checkbox_node.set_pressed(true)

func get_value():
  var value = null
  
  if checkbox_node.is_pressed():
    value = range_node.get_value()

  return value

func set_value(raw_value):
  var valid = raw_value != null
  var value = 0

  if valid:
    value = float(raw_value)

  checkbox_node.set_pressed(valid)
  toggle_checkbox(valid)

  range_node.set_value(value)
  update_spinbox_value(value)
