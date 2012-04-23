
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

#$(".make-grid").kendoGrid({
#  scrollable: true,
#  sortable: true,
#  editable: true
#})
#

$(".make-grid").buhinGrid()

$(".make-datepicker").datepicker()
