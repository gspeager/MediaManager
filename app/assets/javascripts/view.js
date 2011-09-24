// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery
//= require jquery_ujs

$(document).ready(function(){

	var jplayer = $('#jquery_jplayer_1'); 
	var ext = jplayer.attr('data_media_extension');
	var mediaId = jplayer.attr('data_media_id');
	var type = jplayer.attr('data_media_type');
	var mediaUrl = "/play/" + type + "/" + mediaId

	jplayer.jPlayer({
		ready: function (event) {
			$(this).jPlayer("setMedia", {
				mp3: mediaUrl,
			});
		},
		swfPath: "js",
		supplied: "mp3"
	});
 
});