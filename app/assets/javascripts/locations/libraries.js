// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $( ".edit-link" ).last().text("Add Floor")
  $( ".edit-link" ).last().siblings("input,label").remove()

  $( ".edit-link" ).on( "click", function(event) {
    event.preventDefault();
    console.log(this);
    $(this).siblings('.floor-form').toggle();
  });
})
