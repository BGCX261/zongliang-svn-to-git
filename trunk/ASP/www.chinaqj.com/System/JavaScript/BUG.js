
function addTab()
{

	var obj = document.getElementById("tb_BTags")
	var liarys = obj.getElementsByTagName("tr");
	var nid = liarys.length-4;
	
	var ntr = document.createElement('tr');
	var ntd = document.createElement('td');
	ntd.align = "right";
	ntd.className = "forumRow";
	var ntxtid = document.createElement('input');
	ntxtid.type = "text";
	ntxtid.id = "txt_id_" + nid;
	ntxtid.name = "txt_id_" + nid;
	ntxtid.className = "txt_rd";
	ntxtid.value = "0";
	ntxtid.readonly = "readonly";
	
	ntd.appendChild(ntxtid);
	
	var ntd1 = document.createElement('td');
	ntd1.className = "forumRowHighlight";
	var ntxtval = document.createElement('input');
	ntxtval.type = "text";
	ntxtval.id = "txt_val_" + nid;
	ntxtval.name = "txt_val_" + nid;
	ntxtval.className = "txt_ed";
	ntxtval.value = "";
	
	ntd1.appendChild(ntxtval);
	ntd1.innerHTML = ntd1.innerHTML + "<span style='margin-left:20px'>&nbsp;</span><a href='javascript:;' onclick='del(this);'>Delete</a>";
	
	ntr.appendChild(ntd);
	ntr.appendChild(ntd1);
	
	obj.appendChild(ntr);
	
	var obj = document.getElementById("tb_BTags")
	var liarys = obj.getElementsByTagName("tr");
	
	obj.appendChild(liarys[liarys.length-3]);
	
	var obj = document.getElementById("tb_BTags")
	var liarys = obj.getElementsByTagName("tr");
	
	obj.appendChild(liarys[liarys.length-3]);
	
}

function del(obj)
{
	if(obj != null){
		obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
	}
}

