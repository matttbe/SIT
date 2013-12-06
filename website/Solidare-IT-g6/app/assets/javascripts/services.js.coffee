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
	$("#sticker").sticky({topSpacing:0, className:"sticker-active"});
	$("#sticker-filter").sticky({topSpacing:130});
	$("select").selectpicker({style: 'btn', menuStyle: 'dropdown'});
	$('a.load-more-services').on 'inview', (e, visible) ->
    	return unless visible
    	
    	$.getScript $(this).attr('href')
    	
    append = (e) ->
    	path = "/child_categories/#{e.target.value}"
    	$.getJSON path, (json) ->
    		$(e.target).attr("id","service_category_id_0");
    		select = document.createElement("select")
    		$("#categories").append(select)
    		for cat in json 
    			option = document.createElement("option")
    			$(option).attr("value", cat.id)
    			$(option).append(cat.title)
    			$(select).append(option)
    		$(".new-cat").remove()
    		$(select).attr("name", "service[category_id]")
    		$(select).attr("class", "new-cat")
    		$(select).attr("id","service_category_id");
    		$(select).selectpicker({style: 'btn', menuStyle: 'dropdown'});
    $("#service_category_id").change (e) ->
    	append e
    options = 
        valueNames: [ 'service-title' ]

    serviceList = new List('matching', options);