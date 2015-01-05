CsscombRangeFinder = require './csscomb-range-finder'
Comb = require 'csscomb'
fs = require 'fs'
CSON = require 'season'

module.exports =
  activate: (state) ->
    atom.workspaceView.command 'csscomb:run', '.editor', ->
      csscomb atom.workspaceView.getActivePaneItem()

findConfig = ->
  userConfig = atom.config.get 'csscomb'
  if userConfig
    console.log 'Found user CSScomb config:', userConfig
    userConfig
  else
    jsonConfig = atom.project.resolve '.csscomb.json'
    csonConfig = atom.project.resolve '.csscomb.cson'
    if fs.existsSync jsonConfig
      console.log 'Found project CSScomb config:', jsonConfig
      require jsonConfig
    else if fs.existsSync csonConfig
      console.log 'Found project CSScomb config:', csonConfig
      CSON.readFileSync csonConfig
    else
      console.log 'Could not find project CSScomb config, using default: \'csscomb\''
      'csscomb'

syntaxes =
  supported: [
    'css'
    'sass'
    'scss'
    'less'
  ]
  default: 'css'

csscomb = (editor) ->
  ranges = CsscombRangeFinder.rangesFor editor
  title = editor.getTitle()
  throw new Error 'No editor selected' unless title?
  syntax = (editor.getTitle().split '.').pop()
  syntax = syntaxes.default unless syntax in syntaxes.supported
  config = findConfig()
  comb = new Comb config
  ranges.forEach (range) ->
    content = editor.getTextInBufferRange range
    result = comb.processString content, syntax: syntax
    editor.setTextInBufferRange range, result
