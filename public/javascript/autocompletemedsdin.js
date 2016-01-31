$(function() { 
  $("#din").autocomplete({
    source: "/autocomplete_med_din",
    select: function(event, ui) { 
      console.log(ui);
      $.get( "/medname", { med_name: ui.item.label} )
        .done(function( data ) {
          console.log(data);
        $("#med_name").attr("value", data);
      });
    }
  });
});

