#
# * jQuery TableFix plugin ver 1.0.1
# * ver 1.0.1 2012 nakaya
# * Copyright (c) 2010 Otchy
# * This source file is subject to the MIT license.
# * http://www.otchy.net
#
(($) ->
  $.fn.tablefix = (options) ->
    @each (index) ->

      # 処理継続の判定
      baseTable = $(this)
      withWidth = (options.width > 0)
      withHeight = (options.height > 0)

      withWidth = (options.width < baseTable.width());
      options.width = baseTable.width() unless withWidth
      withHeight = (options.height < baseTable.height());
      options.height = baseTable.height() unless withHeight

      # 外部 div の設定
      baseTable.wrap "<div></div>"
      div = baseTable.parent()
      div.css position: "relative"

      # スクロール部オフセットの取得
      fixRows = (if (options.fixRows > 0) then options.fixRows else 0)
      fixCols = (if (options.fixCols > 0) then options.fixCols else 0)
      offsetX = 0
      offsetY = 0
      baseTable.find("tr").each (indexY) ->
        $(this).find("td,th").each (indexX) ->
          if indexY is fixRows and indexX is fixCols
            cell = $(this)
            offsetX = cell.position().left + 1
            offsetY = cell.parent("tr").position().top + 1
            false

        false  if indexY is fixRows

      # テーブルの分割と初期化
      crossTable = baseTable.wrap("<div></div>")
      rowTable = baseTable.clone().wrap("<div></div>")
      colTable = baseTable.clone().wrap("<div></div>")
      bodyTable = baseTable.clone().wrap("<div></div>")
      crossDiv = crossTable.parent().css(
        position: "absolute"
        overflow: "hidden"
      )
      rowDiv = rowTable.parent().css(
        position: "absolute"
        overflow: "hidden"
      )
      colDiv = colTable.parent().css(
        position: "absolute"
        overflow: "hidden"
      )
      bodyDiv = bodyTable.parent().css(
        position: "absolute"
        overflow: "auto"
      )
      bodyDiv.addClass("scroll-pane")
      div.append(rowDiv).append(colDiv).append(bodyDiv)

      # クリップ領域の設定
      bodyWidth = options.width - offsetX
      bodyHeight = options.height - offsetY
      crossDiv.width(offsetX).height offsetY
      rowDiv.width(bodyWidth + ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 0))).height(offsetY).css left: offsetX + "px"
      rowTable.css
        position: "absolute"
        marginLeft: -offsetX + "px"
        marginRight: ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 0)) + "px"

      colDiv.width(offsetX).height(bodyHeight + ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 0))).css top: offsetY + "px"
      colTable.css
        position: "absolute"
        marginTop: -offsetY + "px"
        marginBottom: ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 0)) + "px"

      bodyDiv.width(bodyWidth + ((if withWidth then 0 else 5)) + ((if withHeight then 15 else 0))).height(bodyHeight + ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 20))).css
        left: offsetX + "px"
        top: offsetY + "px"

      bodyTable.css
        position: "absolute"
        marginLeft: -offsetX + "px"
        marginTop: -offsetY + "px"
        marginRight:  ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 0)) + 'px'
        marginBottom: ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 0)) + 'px'

      rowTable.width bodyTable.width()  if withHeight

      # 外部 div の設定
      div.width(options.width + ((if withWidth then 0 else 0)) + ((if withHeight then 0 else 0))).height options.height + ((if withWidth then 20 else 0)) + ((if withHeight then 0 else 0))
      if withWidth and withHeight
        div.height options.height
        rowDiv.width bodyWidth - 14
        colDiv.height bodyHeight - 20
        bodyDiv.width bodyWidth
        bodyDiv.height bodyHeight

      # スクロール連動
      bodyDiv.scroll ->
        rowDiv.scrollLeft bodyDiv.scrollLeft()
        colDiv.scrollTop bodyDiv.scrollTop()
        
) jQuery