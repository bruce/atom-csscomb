CsscombRangeFinder = require './csscomb-range-finder'
Comb = require "csscomb"
fs = require "fs"
CSON = require "season"

module.exports =

  activate: (state) ->
    atom.workspaceView.command 'csscomb:run', '.editor', ->
      editor = atom.workspaceView.getActivePaneItem()
      csscomb(editor)

config = ->
  jsonConfig = atom.project.resolve(".csscomb.json")
  csonConfig = atom.project.resolve(".csscomb.cson")
  if fs.existsSync(jsonConfig)
    console.log "Found project CSSComb config:", jsonConfig
    require jsonConfig
  else if fs.existsSync(csonConfig)
    console.log "Found project CSSComb config:", csonConfig
    CSON.readFileSync(csonConfig)
  else
    console.log "Could not find project CSSComb config, using default: 'csscomb'"
    "csscomb"

csscomb = (editor) ->
  ranges = CsscombRangeFinder.rangesFor(editor)
  syntax = editor.getTitle()?.split('.').pop()
  unless syntax in ['css', 'scss', 'sass', 'less']
    syntax = 'css'
  ranges.forEach (range) ->
    content = editor.getTextInBufferRange(range)
    comb = new Comb(config())
    result = comb.processString(content, syntax)
    editor.setTextInBufferRange(range, result)
