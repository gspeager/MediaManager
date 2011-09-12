$(document).ready(function(){
 
	$('.editLink').live("click", function(){
		var editLink = $(this);
		$('#songEditSection_' + this.id.split('_')[1]).slideToggle('slow');
		if(editLink.text() == 'edit') editLink.text('close');
		else editLink.text('edit')
	});

});