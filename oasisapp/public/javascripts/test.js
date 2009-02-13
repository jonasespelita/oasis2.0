jQuery().ready(function(){
		// simple accordion
		jQuery('.woof').accordion({
		alwaysOpen: false,
		active: false,
		header:"a.t_tab"
});



	});
jQuery(function( $ ){
	/**
	 * THIS BLOCK IS SPECIFICALLY FOR THE DEMO
	 * Binding of the section links, to load other sections inside the content div
	 */
    /*
	var $sections = $('#t_menu_2 a'),// Links on the left
		last = null;// Last section

	$sections.click(function(){
		if( last != this ){ // let's avoid needless requests
			var url = this.hash.slice(1) + '.html';
			$('.scrollit').html( '<p class="loading">Loading...</p>' ).load( url, function(){
				this.scroll= 0;//scroll back to the left
			});
		}
		last = this;
		this.blur(); // Remove the awful outline
		return false;
	});

	$sections.eq(0).click(); // Load the first section

	/**
	 * Actual call to jQuery.localScroll.
	 * Most jQuery.LocalScroll's defaults, belong to jQuery.ScrollTo, check it's demo for an example of each option.
	 * @see http://flesler.demos.com/jquery/scrollTo/
	 */

	$('.scrollit').localScroll({// Only the links inside that jquery object will be affected
		lazy: true, // This is the KEY setting here, makes the links work even after an Ajax load.
		target: '.scrollit', // The element that gets scrolled
		axis:'x', // Horizontal scrolling
		duration:500,
		onBefore:function( e, subsec, $cont ){//'this' is the clicked link
			if( this.blur )
				this.blur(); // Remove the awful outline
		}
	});
});