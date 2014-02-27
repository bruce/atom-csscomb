CsscombRangeFinder = require './csscomb-range-finder'
Comb = require "csscomb"

module.exports =

  activate: (state) ->
    atom.workspaceView.command 'csscomb:run', '.editor', ->
      editor = atom.workspaceView.getActivePaneItem()
      csscomb(editor)

csscomb = (editor) ->
  ranges = CsscombRangeFinder.rangesFor(editor)
  syntax = editor.getTitle()?.split('.').pop()
  unless syntax in ['css', 'scss', 'sass', 'less']
    syntax = 'css'
  ranges.forEach (range) ->
    content = editor.getTextInBufferRange(range)
    comb = new Comb("zen")
    result = comb.processString(content, syntax)
    editor.setTextInBufferRange(range, result)
