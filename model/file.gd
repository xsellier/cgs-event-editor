extends Node

signal save

func save(path, data):
  var savegame = File.new()
  var save_filename = path

  savegame.open(save_filename, File.WRITE)
  
  savegame.store_line(data.to_json())
  savegame.close()

  emit_signal('save')

func read(path):
  var savegame = File.new()
  var save = null

  if savegame.file_exists(path):
    save = {}

    savegame.open(path, File.READ)
    
    var raw_content = savegame.get_as_text()
    
    savegame.close()
    save.parse_json(raw_content)

  return save
