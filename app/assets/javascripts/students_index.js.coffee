SetGrid = (DataSource) ->
  DateW = 95
  $("#grid").kendoGrid
    dataSource:
      data: DataSource
      pageSize: g_num

    height: (g_num + 1) * 36
    groupable: true
    scrollable: false
    sortable: true
    pageable: true
    resizable: true
    reorderable: true
    columns: [
      field: "name"
      title: 'students.name' #これをt("students.name")にしたい。
      width: 128
    ,
      field: "address"
      title: "students.address"
      width: 64
    ,
      field: "address"
      title: "students.address"
      width: 64
    ,
      field: "phone"
      title: "students.phone"
      width: 128
    ,
      field: "birth"
      title: "students.birth"
      width: DateW
    ,
      field: "admitted"
      title: "students.admitted"
      width: DateW
    ,
      field: "graduated"
      title: "students.graduated"
      width: DateW
    ,
      field: "address"
      title: "students.address"
      width: 64
    ,
      field: "manage",
      title: "manage",
      width: 183,
      encoded: false
     ]
  $("a[rel=popover]").popover(
    trigger: "manual"
    animation: true
  ).click (e) ->
    $(e.target).popover "toggle"

  wh = $(window).height()
  gp = $("#grid").position()
  g_num = Math.round((wh - gp.top) / 36) - 2
  $.getJSON "/students.json", (ds) ->
    i = 0

    while i < ds.length
      pop = "<a href=\"#\" class=\"btn btn-danger\" rel=\"popover\" title=\"A Title\" data-content=\"test\">hover for popover</a>"
      tag = "<div style=\"float:left\"><a class=\"k-button\" href=\"/students/" + ds[i].id + "\">表示</a><a class=\"k-button\" href=\"/students/" + ds[i].id + "/edit\">編集</a></div>"
      ds[i]["manage"] = pop
      i++
    SetGrid ds