# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready ->
  $("#join").on("ajax:success", (e, data, status, xhr) ->
    $("#join").empty()
    $("#join").append "<p>USER ADDED</p>").bind "ajax:error", (e, xhr, status, error) ->
      $("#join").append "<p>ERROR</p>"
