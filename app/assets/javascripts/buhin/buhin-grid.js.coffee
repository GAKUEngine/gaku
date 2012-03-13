#= require buhin/buhin-base

class BuHinGrid extends BuHin
  init: () ->
    @target.addClass("buhin-grid ui-widget ui-widget-content")
    @target.find("tr:first").addClass("ui-widget-header")
    

$.fn.buhinGrid = (options) ->
  pluginName = 'buhinGrid'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new BuHinGrid(@))

    $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @
