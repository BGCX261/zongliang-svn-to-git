$(function(){	
	$("#slider").easySlider({
		auto: true,
		continuous: true 
	});
});
$(function() {
    $("#nav li").prepend("<span></span>"); 
    $("#nav li").each(function() { 
		var linkText = $(this).find("a").html();
		if ($(this).find("a").attr("id") != "nav_show")
			$(this).find("span").show().html(linkText);
		else
			$(this).find("span").remove();
	}); 
   $("#nav li").hover(function() {	
		$(this).find("span").stop().animate({
			marginTop:"-37"
		}, 250);
	} , function() {
		$(this).find("span").stop().animate({
			marginTop:"0"
		}, 250);
	});
});
$(function(){
   $("ul.ser_nav li").hover(function(){
	       $(this).find("a").stop().animate({
				top: "-6px"
			},120);
	},function(){
	       $(this).find("a").stop().animate({
				top: "0"
			},120);
	});
});
$(function(){
$(".case_zoom li").find("a").fancyzoom();
});


document.write("<style>.backToTop { display: none; width: 18px; line-height: 1.2; padding: 5px 0; background-color: #000; color: #fff; font-size: 12px; text-align: center; position: fixed; _position: absolute; right: 10px; bottom: 100px; _bottom:'auto'; cursor: pointer; opacity: 0.6; filter: Alpha(opacity=60);}</style>");

$(function(){
	(function() {
		var $backToTopTxt = "\u8fd4\u56de\u9876\u90e8", $backToTopEle = $('<div class="backToTop"></div>').appendTo($("body"))
			.text($backToTopTxt).attr("title", $backToTopTxt).click(function() {
				$("html, body").animate({ scrollTop: 0 }, 1000);
		}), $backToTopFun = function() {
			var st = $(document).scrollTop(), winh = $(window).height();
			(st > 0)? $backToTopEle.show(): $backToTopEle.hide();    
			if (!window.XMLHttpRequest) {
				$backToTopEle.css("top", st + winh - 166);    
			}
		};
		$(window).bind("scroll", $backToTopFun);
		$(function() { $backToTopFun(); });
	})();
});
