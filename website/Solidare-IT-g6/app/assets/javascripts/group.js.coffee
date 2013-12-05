# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).on "ready page:change", ->
	$("#join").on("ajax:success", (e, data, status, xhr) ->
		$("#join").empty()
		response = xhr.responseJSON
		if response.error
			$("#join").append response.error
		else
			$("#join").append response.firstname+" "+response.name)
	$("#join").on "ajax:error", (e, xhr, status, error) ->
		$("#join").append "<p>ERROR</p>"