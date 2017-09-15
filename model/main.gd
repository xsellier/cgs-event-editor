extends Node

var model_diretory = 'res://model'
var model_list = {}
var model_list_instance = null

func _init():
  var model_regex = RegEx.new()
  var dir = Directory.new()

  model_regex.compile('.*\\.gd[c]{0,1}$')

  if dir.open(model_diretory) == OK:
    dir.list_dir_begin()

    var filename = dir.get_next()

    while filename != '':
      var model_name = filename.basename()

      if !dir.current_is_dir() and model_regex.find(filename, 0) >= 0 and model_name != 'generic' and model_name != 'main':
        model_list[model_name] = load('%s/%s' % [model_diretory, filename])

      filename = dir.get_next()

func _ready():
  # Ensure the model is clean
  for child in self.get_children():
    self.remove_child(child)

  model_list_instance = {}

  for key in model_list:
    var model = model_list[key]

    model_list_instance[key] = model.new()

    add_child(model_list_instance[key])

func get_model(name):
  return model_list_instance[name]

func get_models():
  return model_list_instance

func get_model_names():
  return model_list_instance.keys()

