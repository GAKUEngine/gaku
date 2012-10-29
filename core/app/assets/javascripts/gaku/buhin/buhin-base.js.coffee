###############################################################################
# 部品 - The BuHin Widget Library
# Created by Genshin Souzou Kabushiki Kaisha [幻信創造株式会社作]
# Copyright 2012 Genshin Souzou Kabushiki Kaisha/All Rights Reserved
#
# This library is licensed under the GPLv3, alternative licenses can be issued
# on a per-case basis. Please E-Mail info@genshin.org for consultations.
# The GPLv3 can be found at: http://www.gnu.org/licenses/gpl-3.0.html
# このライブラリはライセンス[利用許諾]としてGPLv3を利用しています。
# GPLv3以外のライセンスが必要な場合はinfo@genshin.orgにて相談して下さい。
# GPLv3の和訳: http://sourceforge.jp/magazine/07/09/02/130237
###############################################################################

root = exports ? this
$ = jQuery

class BuHin
  target: null

  constructor: (toTarget, options) ->
    @target = $(toTarget)
    @init(options)
    @target.trigger("buhin-ready")

  init: (options) ->

  ProcessOptions: (options) ->


# make class externally accesasble
root.BuHin = BuHin
