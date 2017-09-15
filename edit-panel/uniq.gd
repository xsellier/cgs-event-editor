extends Control

onready var fans_node = get_node('Fans %')
onready var cost_node = get_node('Costs')
onready var date_node = get_node('Date')
onready var unlock_game_type = get_node('Unlock game type')
onready var unlock_targetted_audience = get_node('Unlock targetted audience')

func get_data():
  var data = {
    'type': 'uniq',
    'date': date_node.get_value(),
    'actions': []
  }

  var action = {
    'button': 'ok',
  }

  if cost_node.get_value() != null:
    action['cost'] = cost_node.get_value()

  if fans_node.get_value() != null:
    action['fan'] = fans_node.get_value()

  if unlock_game_type.get_value() != null:
    action['unlock_game_type'] = unlock_game_type.get_value()

  if unlock_targetted_audience.get_value() != null:
    action['unlock_targetted_audience'] = unlock_targetted_audience.get_value()

  data.actions.append(action)

  return data

func initialize(event):
  if event != null:
    # Only one action for a uniq event
    var action = event.actions[0]

    if action.has('fan'):
      fans_node.set_value(action.fan)

    if action.has('cost'):
      cost_node.set_value(action.cost)

    if action.has('date'):
      date_node.set_value(action.date)

    if action.has('unlock_game_type'):
      unlock_game_type.set_value(action.unlock_game_type)

    if action.has('unlock_targetted_audience'):
      unlock_targetted_audience.set_value(action.unlock_targetted_audience)