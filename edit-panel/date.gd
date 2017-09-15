extends Control

onready var key_node = get_node('key')
onready var year = get_node('year')
onready var month = get_node('month')
onready var week = get_node('week')

func _ready():
  var key_name = get_name()

  key_node.set_text(key_name)

func get_value():
  var year_value = int(year.get_value())
  var month_value = int(month.get_value())
  var week_value = int(week.get_value())

  return '%s-%s-%s' % [year_value, month_value, week_value]

func set_value(raw_value):
  var valid = raw_value != null

  if valid:
    var value = raw_value.split_floats('-')
    var year_value = value[0]
    var month_value = value[1]
    var week_value = value[2]

    year.set_value(year_value)
    month.set_value(month_value)
    week.set_value(week_value)
  