var getArgs=(function(){
    var sc=document.getElementsByTagName('script');
    var paramsArr=sc[sc.length-1].src.split('?')[1].split('&');
    var args={},argsStr=[],param,t,name,value;
    for(var i=0,len=paramsArr.length;i<len;i++){
        param=paramsArr[i].split('=');
        name=param[0],value=param[1];
        if(typeof args[name]=="undefined"){
            args[name]=value;
        }
        else if(typeof args[name]=="string"){
            args[name]=[args[name]]
            args[name].push(value);
        }
        else{
            args[name].push(value);
        }
    }
    var showArg=function(x){
        if(typeof(x)=="string"&&!/\d+/.test(x)) return "'"+x+"'";
        if(x instanceof Array) return "["+x+"]"
        return x;
    }
    args.toString=function(){
        for(var i in args) argsStr.push(i+':'+showArg(args[i]));
        return '{'+argsStr.join(',')+'}';
    }
    return function(){
        return args;
    }
}
)();
var owner = "www.chinaqj.com";var sf_mess_cfg = {theme:getArgs()["SkinA"],color:getArgs()["SkinB"],title:"客户购买意向咨询",send:"发送咨询",copyright:"www.chinaqj.com",mbpos:"RD"};var sf_mess_msg = {emailErr: '请填写正确的电子信箱地址！',messErr: '您的留言字数已超过限制，请保留在1000个字以内！',prefix: '请填写',success: '我们已经收到您的留言，稍候会与您联系。谢谢！',fail: '我们已经收到您的留言，稍候会与您联系。谢谢！'};var sf_mess_cols = [{type:"textarea",mbtype: "message",tip: "咨询、反馈内容",innertip: "如果您需要购买我们的任何产品或对我们的产品有任何疑问，请留言。我们会及时联系您！",idname: "content"},{type:"text",mbtype: "tel",tip: "手机号码",innertip: "请输入您的手机号码",idname: "phone"},{type:"text",mbtype: "email",tip: "电子邮箱",innertip: "请输入您的电子邮箱",idname: "email"},{type:"text",mbtype: "address",tip: "联系地址",innertip: "请输入您的联系地址",idname: "addr"}];document.write('<script src="../scripts/entry.js" type="text/javascript"></script>');