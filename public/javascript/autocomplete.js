$(function() { 
  $("#food_name").autocomplete({
    source: "/autocomplete_food_name",
    select: function(event, ui) { 
      console.log(ui);
      $.get( "/fooditem", { food_name: ui.item.label} )
        .done(function( data ) {
          console.log(data);
        $("#food_portions").attr("placeholder", data + " per portion");
      });
    }
  });
});
