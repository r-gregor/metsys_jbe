var page,
	navLinks;

	
$(document).ready(function() {
	$('html').removeClass('no-js'); // Remove this if using Modernizr

	var isMobile,
		isAndroid = (/android/gi).test(navigator.appVersion),
		isIDevice = (/iphone|ipad|ipod/gi).test(navigator.appVersion),
		isPlaybook = (/playbook/gi).test(navigator.appVersion),
		isTouchPad = (/hp-tablet/gi).test(navigator.appVersion);
	
	isMobile = (isAndroid || isIDevice || isPlaybook || isTouchPad);

	if (isMobile) {
		$("html").addClass("mobile");
		page = $('html,body');
	} else {
		page = $('#main');
	}
	
	/* External links (just add the "targetblank" class to any link you want) */
	$('a.targetblank').click(function(e) {
		e.preventDefault();
		e.stopPropagation();
		window.open(this.href, '_blank');
	});
			 
	// Tabs (part of Skeleton)
	var tabs = $('ul.tabs');
	tabs.each(function(i) {
		//Get all tabs
		var tab = $(this).find('> li > a');
		tab.mousedown(function(e) {
			//Get Location of tab's content
			var contentLocation = $(this).attr('href');
			//Let go if not a hashed one
			if(contentLocation.charAt(0)=="#") {
				e.preventDefault();
				//Make Tab Active
				tab.removeClass('active');
				$(this).addClass('active');
				//Show Tab Content & add active class
				$(contentLocation).show().addClass('active').siblings().hide().removeClass('active');
			}
		}).click(function(e){
			e.preventDefault();
		});
	});
	
	$(".spanlink").each(convertSpanToLink);

	// Forms: Submit through Ajax
	$("form.send-with-ajax").submit(function(e) {
	/* Add the class "send-with-ajax" to any form you want to have it handled here 
	  (don't forget the div with class="ajax-response" inside the <form> tag!) */
		e.preventDefault();
		var form = $(this),
			validationErrors = false;
		
		// Reset all messages
		$('.form-error-msg').remove();

		// Client-side validation for old browsers
		form.find("input[type='email'], input[required]").each(function(index){
			var inputValue = $(this).val(),
				inputRequired = $(this).attr('required'),
				inputType = $(this).attr('type');

				$(this).removeClass('form-error');
			
			if(inputRequired && inputValue == '') {
				$(this).after('<div class="form-error-msg">Please fill out this field.</div>');
				$(this).addClass('form-error');
				validationErrors = true;
			} else if(inputType == 'email' && !isValidEmail(inputValue)) {
				$(this).after('<div class="form-error-msg">Please enter an email address.</div>');
				$(this).addClass('form-error');
				validationErrors = true;
			}
		});

		if (!validationErrors) {
			form.find('button:submit, input:submit').html('Sending...');
			form.find('.ajax-response').empty();
			$.post(form.attr('name'), form.serialize(),
				function(data) {
					if (data.bFormSent) {
						form.find('.ajax-response').empty().html(data.aResults[0]);
						form.find('button:submit, input:submit').html('Submit Form');
						form.find('#form-email, #form-name, #form-message').val('');
					} else {
						form.find('.ajax-response').empty().wrapInner('<div class="form-error-msg"></div>');
						form.find('.ajax-response div').html(data.aErrors[0]);
						form.find('button:submit, input:submit').html('Try Again');
					}
				}, 'json');
		}
	});
	
}); // <-- document ready


$(window).load(function() {
	// Main slider options
	$('.homepage.flexslider').find('.slides').removeClass('notloaded');
	$('.homepage.flexslider').flexslider({
		animation: "fade",              //String: Select your animation type, "fade" or "slide"
		slideshow: true,                //Boolean: Animate slider automatically
		slideshowSpeed: 10000,           //Integer: Set the speed of the slideshow cycling, in milliseconds
		animationDuration: 600,         //Integer: Set the speed of animations, in milliseconds
		directionNav: false,             //Boolean: Create navigation for previous/next navigation? (true/false)
		controlNav: true,               //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
		keyboardNav: true,              //Boolean: Allow slider navigating via keyboard left/right keys
		mousewheel: false,              //Boolean: Allow slider navigating via mousewheel
		slideToStart: 0,                //Integer: The slide that the slider should start on. Array notation (0 = first slide)
		animationLoop: true,            //Boolean: Should the animation loop? If false, directionNav will received "disable" classes at either end
		pauseOnAction: true,            //Boolean: Pause the slideshow when interacting with control elements, highly recommended.
		pauseOnHover: false            //Boolean: Pause the slideshow when hovering over slider, then resume when no longer hovering
    });
});


/* Functions */
function checkNavIntegrity(){
	// Debug function that checks that all navigation links have appropriate <article> with corresponding ID.
	// You can remove this once you finihed working on the site.
	navLinks.each(function(){
		var linkHref = $(this).attr('href'),
			correspondingArticle = $(linkHref);
			
			if(correspondingArticle.length == 0) {
				var linkValue = $(this).html(),
					targetId = linkHref.replace(/#/, '');
				alert('Navigation Broken: The menu link "'+linkValue+'" points to a nonexistent ID "'+linkHref+'". \n'
					 +'To solve this, add the ID "'+targetId+'" to a tag, for example: <article id="'+targetId+'">');
			}
	});
}

function convertSpanToLink() {
    var span = $(this);
    var text = span.html();
    var url = span.attr("title"); url = " href=\"" + url + "\"";
    var target = span.attr("target"); if (target != undefined) { target = " target=\"" + target + "\""; } else { target = ""; }
    var rel = span.attr("rel"); if (rel != undefined) { rel = " rel=\"" + rel + "\""; } else { rel = ""; }
    var a = "<a " + url + target + rel + "\">" + text + "</a>";
    span.replaceWith(a);
}

function isValidEmail(email) {
    var pattern = new RegExp(/^(("[\w-+\s]+")|([\w-+]+(?:\.[\w-+]+)*)|("[\w-+\s]+")([\w-+]+(?:\.[\w-+]+)*))(@((?:[\w-+]+\.)*\w[\w-+]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][\d]\.|1[\d]{2}\.|[\d]{1,2}\.))((25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\.){2}(25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\]?$)/i);
    return pattern.test(email);
};

function fnTogglePastNews() {
    $(".readPastNews").toggleClass("hide");
    $(".hidePastNews").toggleClass("hide");
    $(".pastNews").toggleClass("hide");
}

function fnTrackDedicatedVpnForm() {
	var location = $('input:radio[name=location]:checked').val();
	try { ga('send', 'event', 'Dedicated VPN', 'Subscribe', location); } catch (ex) { }
	return true;
}

function fnWebProxyFormSubmit()
{
	var proxies  = ["https://usproxy.vpnbook.com/includes/process.php?action=update", "https://ukproxy.vpnbook.com/includes/process.php?action=update", "https://webproxy.vpnbook.com/includes/process.php?action=update"];
	var proxyurl = proxies[Math.floor(Math.random()*3)];
	var proxy = $("#webproxylocation").val();	
	if (proxy == "us")
	{
		proxyurl = proxies[0];		
	}
	if (proxy == "uk")
	{
		proxyurl = proxies[1];
	}
	if (proxy == "ca")
	{
		proxyurl = proxies[2];
	}
	$("#webproxyform").attr("action", proxyurl);
}

$(document).ready(function() {
	$('.vpnsteps.flexslider').find('.slides').removeClass('notloaded');
	$('.vpnsteps.flexslider').flexslider({
		animation: "slide",             //String: Select your animation type, "fade" or "slide"
		slideshow: false,               //Boolean: Animate slider automatically
		slideshowSpeed: 1000,           //Integer: Set the speed of the slideshow cycling, in milliseconds
		animationDuration: 500,         //Integer: Set the speed of animations, in milliseconds
		directionNav: true,             //Boolean: Create navigation for previous/next navigation? (true/false)
		controlNav: true,               //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
		keyboardNav: true,              //Boolean: Allow slider navigating via keyboard left/right keys
		mousewheel: false,              //Boolean: Allow slider navigating via mousewheel
		slideToStart: 0,                //Integer: The slide that the slider should start on. Array notation (0 = first slide)
		animationLoop: false,           //Boolean: Should the animation loop? If false, directionNav will received "disable" classes at either end
		pauseOnAction: true,            //Boolean: Pause the slideshow when interacting with control elements, highly recommended.
		pauseOnHover: false             //Boolean: Pause the slideshow when hovering over slider, then resume when no longer hovering
    });
});