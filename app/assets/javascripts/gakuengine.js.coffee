
###############################################################################
# Automatic conversions
# classes staring with "make-" are picked up here and automatically converted
###############################################################################

#$(document).ready( ->
  # Create top menubar
  # メニューバーのメニューを作る
  #$("#menubarMenu").kendoMenu()

# Create buttons
# ボタン作成
$(".make-button").button() #addClass("k-button")

$(".make-grid").buhinGrid()
#kendoGrid({
#  height: 400,
#  sortable: true,
#  selectable: true
#})
#)

$(".make-datepicker").datepicker()
