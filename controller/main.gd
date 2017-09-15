extends Node

var controller_diretory = 'res://controller'
var controller_list = {}
var controller_list_instance = null

func _init():
  var controller_regex = RegEx.new()
  var dir = Directory.new()

  controller_regex.compile('.*\\.gd[c]{0,1}$')

  if dir.open(controller_diretory) == OK:
    dir.list_dir_begin()

    var filename = dir.get_next()

    while filename != '':
      var controller_name = filename.basename()

      if !dir.current_is_dir() and controller_regex.find(filename, 0) >= 0 and controller_name != 'generic' and controller_name != 'main':
        controller_list[controller_name] = load('%s/%s' % [controller_diretory, filename])

      filename = dir.get_next()

func _ready():
  # Ensure the controller is clean
  for child in self.get_children():
    self.remove_child(child)

  controller_list_instance = {}

  for key in controller_list:
    var controller = controller_list[key]

    controller_list_instance[key] = controller.new()

    add_child(controller_list_instance[key])

func get_controller(name):
  return controller_list_instance[name]

func get_controllers():
  return controller_list_instance

func get_controller_names():
  return controller_list_instance.keys()

