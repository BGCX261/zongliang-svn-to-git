<%
	Dim poText
		poText=Request.Form("SiteDetail")
	Dim poText2
		poText2=Request.Form("content")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>测试编辑器</title>
	<script type="text/javascript" src="/Scripts/ueditor/editor_config.js"></script>
	<script type="text/javascript" src="/Scripts/ueditor/editor_all.js"></script>
	<link rel="stylesheet" href="/Scripts/ueditor/themes/default/ueditor.css"/>
  </head>
  <body>
	
	<center>
	
	<form action="?" method="post">
	
	<textarea name="SiteDetail" id="SiteDetail"><%=poText %></textarea>
	<script type="text/javascript">
		var editor = new baidu.editor.ui.Editor();
		editor.render("SiteDetail");
	</script>

	<input type="submit" value="Test" />

	</form>

	</center>

	<div style="border: 1px dashed #2F6FAB; background-color: #C6E2FF; margin-left: auto; margin-right: auto; width:80%; height:100%;"><%=poText %></div>

	<hr />

	<script charset="utf-8" src="/Scripts/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/Scripts/kindeditor/editor/lang/zh_CN.js"></script>
	<center>
	<form action="?" method="post">
	<textarea id="editor_id" name="content" style="width:700px;height:300px;"><%=poText2 %></textarea>
	<input type="submit" value="Test" />
	</form>
	</center>
	<script>
			//var editor;
			//KindEditor.ready(function(K) {
			//		editor = K.create('#editor_id');
			//});
		KindEditor.ready(function(K) {
			var editor = K.create('textarea[name="content"]', {
				cssPath : '/Scripts/kindeditor/plugins/code/prettify.css',
				uploadJson : '/Scripts/kindeditor/asp/upload_json.asp',
				fileManagerJson : '/Scripts/kindeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				resizeType:0,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
				}
			});
			prettyPrint();
		});

	</script>
	
	<div style="border: 1px dashed #2F6FAB; background-color: #C6E2FF; margin-left: auto; margin-right: auto; width:80%; height:100%;"><%=poText2 %></div>

  </body>
</html>