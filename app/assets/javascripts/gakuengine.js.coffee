
###############################################################################
# Automatic conversions
# classes staring with "make-" are picked up here and automatically converted
###############################################################################

$(document).ready( ->
  # Create buttons
  # ボタン作成
  $(".make-button").button()

  $(".make-grid").kendoGrid({
    height: 360,
    sortable: true,
    selectable: true
  })
)
