/*
 * jQuery TableFix plugin ver 1.0.0
 * Copyright (c) 2010 Otchy
 * This source file is subject to the MIT license.
 * http://www.otchy.net
 */
(function($){
	$.fn.tablefix = function(options) {
		return this.each(function(index){
			// 処理継続の判定
			var baseTable = $(this);
			var withWidth = (options.width > 0);
			var withHeight = (options.height > 0);
			if (withWidth) {
				// withWidth = (options.width < baseTable.width());
			} else {
				options.width = baseTable.width();
			}
			if (withHeight) {
				// withHeight = (options.height < baseTable.height());
			} else {
				options.height = baseTable.height();
			}
			if (withWidth || withHeight) {
				if (withWidth && withHeight) {
					options.width -= 40;
					options.height -= 0;
				} else if (withWidth) {
					options.width -= 20;
				} else {
					options.height -= 0;
				}
			} else {
				return;
			}
			// 外部 div の設定
			baseTable.wrap("<div></div>");
			var div = baseTable.parent();
			div.css({position: "relative"});
			// スクロール部オフセットの取得
			var fixRows = (options.fixRows > 0) ? options.fixRows : 0;
			var fixCols = (options.fixCols > 0) ? options.fixCols : 0;
			var offsetX = 0;
			var offsetY = 0;
			baseTable.find('tr').each(function(indexY) {
				$(this).find('td,th').each(function(indexX){
					if (indexY == fixRows && indexX == fixCols) {
						var cell = $(this);
						offsetX = cell.position().left + 1;
						offsetY = cell.parent('tr').position().top + 1;
						return false;
					}
				});
				if (indexY == fixRows) {
					return false;
				}
			});
			// テーブルの分割と初期化
			var crossTable = baseTable.wrap('<div></div>');
			var rowTable = baseTable.clone().wrap('<div></div>');
			var colTable = baseTable.clone().wrap('<div></div>');
			var bodyTable = baseTable.clone().wrap('<div></div>');
			var crossDiv = crossTable.parent().css({position: "absolute", overflow: "hidden"});
			var rowDiv = rowTable.parent().css({position: "absolute", overflow: "hidden"});
			var colDiv = colTable.parent().css({position: "absolute", overflow: "hidden"});
			var bodyDiv = bodyTable.parent().css({position: "absolute", overflow: "auto"});
			div.append(rowDiv).append(colDiv).append(bodyDiv);
			// クリップ領域の設定
			var bodyWidth = options.width - offsetX;
			var bodyHeight = options.height - offsetY;
			crossDiv.width(offsetX).height(offsetY);
			rowDiv
				.width(bodyWidth + (withWidth ? 20 : 0) + (withHeight ? 20 : 0))
				.height(offsetY)
				.css({left: offsetX + 'px'});
			rowTable.css({
				marginLeft: -offsetX + 'px',
				marginRight: (withWidth ? 20 : 0) + (withHeight ? 20 : 0) + 'px'
			});
			colDiv
				.width(offsetX)
				.height(bodyHeight + (withWidth ? 20 : 0) + (withHeight ? 20 : 0))
				.css({top: offsetY + 'px'});
			colTable.css({
				marginTop: -offsetY + 'px',
				marginBottom: (withWidth ? 20 : 0) + (withHeight ? 20 : 0) + 'px'
			});
			bodyDiv
				.width(bodyWidth + (withWidth ? 20 : 0) + (withHeight ? 20 : 0))
				.height(bodyHeight + (withWidth ? 20 : 0) + (withHeight ? 20 : 0))
				.css({left: offsetX + 'px', top: offsetY + 'px'});
			bodyTable.css({
				marginLeft: -offsetX + 'px',
				marginTop: -offsetY + 'px',
				marginRight: (withWidth ? 20 : 0) + 'px',
				marginBottom: (withHeight ? 20 : 0) + 'px'
			});
			if (withHeight) {
				rowTable.width(bodyTable.width());
			}
			// スクロール連動
			bodyDiv.scroll(function() {
				rowDiv.scrollLeft(bodyDiv.scrollLeft());
				colDiv.scrollTop(bodyDiv.scrollTop());
			});
			// 外部 div の設定
			div
				.width(options.width + (withWidth ? 20 : 0) + (withHeight ? 20 : 0))
				.height(options.height + (withWidth ? 20 : 0) + (withHeight ? 20 : 0));
		});
	}
})(jQuery);
