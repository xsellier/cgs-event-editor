extends Control

onready var controller = get_node('/root/controller')
onready var event_controller = controller.get_controller('event')

onready var import_dialog = get_node('ImportDialog')
onready var export_dialog = get_node('ExportDialog')

onready var import_button = get_node('list/Import')
onready var export_button = get_node('list/Export')

func _ready():
  import_button.connect('pressed', self, 'import_pressed')
  export_button.connect('pressed', self, 'export_pressed')

  import_dialog.connect('confirmed', self, 'import_file')
  export_dialog.connect('confirmed', self, 'export_file')

  import_dialog.connect('file_selected', self, 'import_file')
  export_dialog.connect('file_selected', self, 'export_file')


func import_pressed():
  import_dialog.show()
  export_dialog.hide()
    
func export_pressed():
  export_dialog.show()
  import_dialog.hide()

func import_file(unused=null):
  var path = import_dialog.get_current_path()

  event_controller.import_file(path)

func export_file(unused=null):
  var path = export_dialog.get_current_path()

  event_controller.export_file(path)
