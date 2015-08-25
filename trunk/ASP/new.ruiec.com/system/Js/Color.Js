var ColorHex=new Array('00','33','66','99','CC','FF');
var SpColorHex=new Array('FF0000','00FF00','0000FF','FFFF00','00FFFF','FF00FF');
$(function(){
    initColor();
    $("#colorpanel").hide();
})

function initColor(){
    $("body").append('<div id="colorpanel" style="position: absolute; display: none;"></div>');
    var colorTable='';
     
		for(var n = 0 ; n < 6 ; n++)
					{
						colorTable=colorTable+('<tr height="11">');
						colorTable=colorTable+('<td style="width:11px;border:1px solid #333;background-color:#'+ColorHex[n]+ColorHex[n]+ColorHex[n]+'"></td>');
						for(var i = 0 ; i < 3; i++)
						{
							for(var j = 0 ; j < 6 ; j++)
							{
								colorTable=colorTable+('<td style="width:11px;border:1px solid #333;background-color:#'+ColorHex[i]+ColorHex[j]+ColorHex[n]+'"></td>');
							}
						}
						colorTable=colorTable+('</tr>');
					}
					for(var n = 0 ; n < 6 ; n++)
					{
						colorTable=colorTable+('<tr height="11">');
						colorTable=colorTable+('<td style="width:11px;border:1px solid #333;background-color:#'+SpColorHex[n]+'"></td>')
						for(var i = 3 ; i < 6; i++)
						{
							for(var j = 0 ; j < 6 ; j++)
							{
								colorTable=colorTable+('<td style="width:11px;border:1px solid #333;background-color:#'+ColorHex[i]+ColorHex[j]+ColorHex[n]+'"></td>');
							}
						}
						 
    }
    
    colorTable='<table width=229 border="0" cellspacing="0" cellpadding="0" style="border:1px #000000 solid;border-bottom:none;border-collapse: collapse" bordercolor="000000">'
               +'<tr height=30><td colspan=21 bgcolor=#cccccc>'
               +'<table cellpadding="0" cellspacing="1" border="0" style="border-collapse: collapse">'
               +'<tr><td width="3"><td><input type="text" id="DisColor" size="6" disabled style="border:solid 1px #000000;background-color:#ffff00"></td>'
               +'<td width="3"><td><input type="text" id="HexColor" size="7" style="border:inset 1px;font-family:Arial;" value="#000000"></td><td><input type="button" value="取消" onclick="close_ColorPanel()" style="background:#D4CFC9;border-left:1px solid #fff;border-top:1px solid #fff;border-right:1px solid #7F7F7F;border-bottom:1px solid #7F7F7F;font-size:12px;margin:0 0 0 50px;cursor:pointer;padding:1px 0 0 0;"></td></tr></table></td></table>'
               +'<table id="CT" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="000000"  style="cursor:pointer;">'
               +colorTable+'</table>';          
    $("#colorpanel").html(colorTable);
}

function showColorPanel(obj,txtobj){

    $('#'+obj).click(function(){
        //定位
        var ttop  = $(this).offset().top;     //控件的定位点高
        var thei  = $(this).height();  //控件本身的高
        var tleft = $(this).offset().left;    //控件的定位点宽
        
        $("#colorpanel").css({top:ttop+thei-18,left:tleft+22})        

        $("#colorpanel").show();
        
        $("#CT tr td").unbind("click").mouseover(function(){
            var aaa=$(this).css("background-color");
            $("#DisColor").css("background-color",aaa);
            $("#HexColor").val(aaa);
        }).click(function(){
            var aaa=$(this).css("background-color");
            $('#'+txtobj).val(aaa);
			 $('#'+obj).css("background", aaa);
            $("#colorpanel").hide();
        })
    })
}
function close_ColorPanel(){$("#colorpanel").hide();}
jQuery.extend({showcolor:function(btnid,txtid){showColorPanel(btnid,txtid);}})
