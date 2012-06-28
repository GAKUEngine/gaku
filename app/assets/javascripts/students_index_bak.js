$(document).ready(function() {
  
  $("a[rel=popover]").popover({trigger:'manual', animation:true}).click(function(e){
    $(e.target).popover('toggle')
  });
         
  var wh = $(window).height();
  var gp = $('#grid').position();
  var g_num = Math.round((wh - gp.top) / 36) - 2;

  function SetGrid(DataSource)
  {
    var DateW = 95;
    
    $("#grid").kendoGrid
    ({
      dataSource:
      {
        data: DataSource,
        pageSize: g_num
      },
      height: (g_num + 1) * 36,
      groupable: true,
      scrollable: false,
      sortable: true,
      pageable: true,
      resizable: true,
      reorderable: true,
      columns:
      [{
          field: "name",
          title: "#{t "students.name"}",
          width: 128
        },{
          field: "address",
          title: "#{t "students.address"}",
          width: 64
        },{
          field: "phone",
          title: "#{t "students.phone"}",
          width: 128
        },{
          field: "email",
          title: "#{t "students.email"}",
          width: 256
        },{
          field: "birth",
          title: "#{t "students.birth"}",
          width: DateW
        },{
          field: "admitted",
          title: "#{t "students.admitted"}",
          width: DateW
        },{
          field: "graduated",
          title: "#{t "students.graduated"}",
          width: DateW
        },{
          field: "manage",
          title: "#{t "manage"}",
          width: 183,
          encoded: false
        }]
    });
  }
  
  $.getJSON("/students.json",function(ds)
  {
    for(var i = 0; i < ds.length; i++)
    {
      var pop = '<a href="#" class="btn btn-danger" rel="popover" title="A Title" data-content="test">hover for popover</a>';
      var tag = '<div style="float:left"><a class="k-button" href="/students/'+ds[i].id+'">表示</a><a class="k-button" href="/students/'+ds[i].id+'/edit">編集</a></div>';
      ds[i]["manage"] = pop;
    }
    SetGrid(ds);
  });
});
