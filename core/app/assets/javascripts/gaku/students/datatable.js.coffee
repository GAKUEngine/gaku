$ ->
  num_rows = $("#students-index").find('tr')[0].cells.length;
  if num_rows == 10
    aoColumns_arr = [
        bSortable: false, null, null, null, null, null, null, null, null, bSortable: false]
  else
    aoColumns_arr = [
        bSortable: false, null, null, null, null, null, null, null, null]
  $("#students-index").dataTable
    bPaginate: false
    bLengthChange: false
    bFilter: false
    bInfo: false
    bAutoWidth: false
    aoColumns: aoColumns_arr
    asStripClasses: null #To remove "odd"/"event" zebra classes