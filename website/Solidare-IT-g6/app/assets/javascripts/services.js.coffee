# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:change", ->
	list = ->
		$('.service-parent').addClass("row-fluid")
		services = $('.service').detach()
		for parent, i in $('.service-parent')
			$(parent).append(services[i])
		$(services).removeClass('span4').addClass('span12')
	grid = ->
		$('.service-parent').removeClass("row-fluid")
		services = $('.service').detach()
		for box, i in $('.service-parent')
			if i % 3 == 0
				$(box).addClass('row-fluid')
				$(box).append(services[i]).append(services[i+1]).append(services[i+2])
		$('.service').removeClass('span12').addClass('span4')
	$('#grid').click ->
		grid()
	$('#list').click ->
		list()

	$('a.load-more-services').on 'inview', (e, visible) ->
    	return unless visible
    	
    	$.getScript $(this).attr('href')