#This file is a library of widgets for GAKUEngine.
#Each widget is a jQuery/jQuery UI plugin, written in coffeescript, with the GE prefix for class, lower case ge for plugin.
#
#= require buhin/buhin-base

class GEGradingWidget extends BuHin
  target: null
  score: 0
  scoreBox: null
  scoreBar: null

  init: () ->
    @score = @target.html()
    @target.html("")
    @scoreBox = $("<input />")
    @scoreBox.attr({value: @score})
    @scoreBox.appendTo(@target)
    @scoreBox.kendoNumericTextBox({
      min: 0,
      max: 100,
      step: 0.5
    })
    @scoreBar = $("<div></div>")
    @scoreBar.progressbar({value: @score}) #why does this not work?
    #@scoreBar.appendTo(@target)
    #@scoreBar.css({display: "block"; width: "200px";})
    return @
  
  ProcessOptions: (options) ->

$.fn.geGradingWidget = (options) ->
  pluginName = 'geGradingWidget'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new GEGradingWidget(@))

    $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @

