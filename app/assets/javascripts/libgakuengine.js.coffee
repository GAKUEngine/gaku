#This file is a library of widgets for GAKUEngine.
#Each widget is a jQuery/jQuery UI plugin, written in coffeescript, with the GE prefix for class, lower case ge for plugin.
#

#root = exports ? this
$ = jQuery

class GEGradingWidget
  target: null
  score: 0
  scoreBox: null
  scoreBar: null

  constructor: (toTarget) ->
    @target = $(toTarget)
    @score = @target.html()
    @target.html("")
    @scoreBox = $("<input />")
    @scoreBox.attr({value: @score})
    @scoreBox.appendTo(@target)
    @scoreBox.kendoNumericTextBox()
  
  ProcessOptions: (options) ->

$.fn.geGradingWidget = (options) ->
  pluginName = 'geGradingWidget'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new GEGradingWidget(@))

    $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @

