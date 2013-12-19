// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.slider
//= require jquery.sticky
//= require turbolinks
//= require jquery.inview.min.js
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-select
//= require bootstrap-switch
//= require bootstrap-typeahead
//= require_directory .
// TODO: disable gmaps when not used
//= require_directory ./gmaps
//= require less-1.5.0.min.js
//= require holder.js
//= require flatui-checkbox
//= require flatui-radio
//= require underscore
//= require list
//= require buttons

$(document).on("ready page:load", function(){
	$("#more").hide();
	$("#q").focus(function(){
		$("#more").show();
	});
	$("#hide-options").click(function(){
		$("#more").hide();
	});
	$(':checkbox').checkbox();
	$('.carousel').carousel();
  var switchTo5x=true;
  stLight.options({publisher: "26ba6107-3f26-45cf-9194-733aa618dbad", doNotHash: false, doNotCopy: false, hashAddressBar: false});
  });