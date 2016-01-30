$(function() { 
  $("#med_name").autocomplete({
    source: "/autocomplete_med_name",
    select: function(event, ui) { 
      console.log(ui);
      $.get( "/meditem", { med_name: ui.item.label} )
        .done(function( data ) {
          console.log(data);
        $("#din").attr("value", data);
      });
    }
  });
});
