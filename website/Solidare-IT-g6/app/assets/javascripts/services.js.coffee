# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:change", ->
	list = ->
		$('.service-parent').addClass("row")
		services = $('.service-box').detach()
		for parent, i in $('.service-parent')
			$(parent).append(services[i])
		$(services).removeClass('col-md-4').addClass('col-md-12')
	grid = ->
		$('.service-parent').removeClass("row")
		services = $('.service-box').detach()
		for box, i in $('.service-parent')
			if i % 3 == 0
				$(box).addClass('row')
				$(box).append(services[i]).append(services[i+1]).append(services[i+2])
		$(services).removeClass('col-md-12').addClass('col-md-4')
	$('#grid').click ->
		grid()
	$('#list').click ->
		list()
	$(':radio').radio();
	$("select").selectpicker({style: 'btn', menuStyle: 'dropdown'});
	$('a.load-more-services').on 'inview', (e, visible) ->
    	return unless visible
    	
    	$.getScript $(this).attr('href')