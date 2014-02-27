module.exports =
  activate: (state) ->
    atom.workspaceView.command "Ruler:toggle", => @toggle()
    if (atom.config.get('Ruler.enabled') == undefined)
      atom.config.set('Ruler.enabled', true)
    if (atom.config.get('Ruler.position') == undefined)
      atom.config.set('Ruler.position', 80)
    @show()

  toggle: ->
    if (atom.config.get('Ruler.enabled') == true)
      atom.config.set('Ruler.enabled', false)
    else
      atom.config.set('Ruler.enabled', true)
    @show()

  show: ->
    if (atom.config.get('Ruler.enabled') == true)
      atom.workspaceView.eachEditorView (ev) ->
        ev.find('.scroll-view').append('<div class="ruler"></div>')
        offset = ev.pixelPositionForBufferPosition([0, 1]).left
        left = (2 * atom.config.get('Ruler.position') + 1) * offset / 2
        ev.find('.ruler').css('left', left + 'px')
    else
      atom.workspaceView.eachEditorView (ev) ->
        ev.find('.ruler').remove()
