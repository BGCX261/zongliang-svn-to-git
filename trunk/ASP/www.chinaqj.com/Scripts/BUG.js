
// on submit
function onSub(){
	
	var title = $("#txt_title").val();
	if (title == ""){
		alert("请输入标题");
		$("#txt_title").focus();
		return false;
	}
	var chk="";
	for (var i=0;i<checkBUG.length;i++ ){
		if(checkBUG[i].checked){ chk=chk+checkBUG[i].value + ","; }
	}
	if (chk == ""){
		alert("请选择BUG");
		$("#checkBUG").focus();
		return false;
	}
	var con = $("#Remark").val();
	if (con == ""){
		alert("请输入说明");
		$("#Remark").focus();
		return false;
	}
	var name = $("#RealName").val();
	if (name == ""){
		alert("请输入您的姓名");
		$("#RealName").focus();
		return false;
	}
	var phone = $("#Telephone").val();
	if (phone == ""){
		alert("请输入您的电话");
		$("#Telephone").focus();
		return false;
	}
	var Email = $("#Email").val();
	if (Email == ""){
		alert("请输入您的邮箱");
		$("#Email").focus();
		return false;
	}
	
	return true;
}