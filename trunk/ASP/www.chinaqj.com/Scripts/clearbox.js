


/*                                                                                                                                                                              
	clearbox by pyro
	
	script home:		http://www.clearbox.hu
	email:			clearboxjs(at)gmail(dot)com
	MSN:			pyro(at)radiomax(dot)hu
	support forum 1:	http://www.sg.hu/listazas.php3?id=1172325655

	LICENSZ FELT蒚ELEK:

	A clearbox szabadon felhaszn醠hat?b醨milyen nem kereskedelmi jelleg?honlapon, 
	teh醫 azokon amelyek nem kereskedelmi tev閗enys間et folytat?c間ek, v醠lalatok 
	oldalai; nem tartalmaznak kereskedelmi jelleg?szolg醠tat醩t vagy term閗(ek) 
	elad醩(?t, illetve rekl醡oz醩(?t. A kereskedelmi jelleg?honlapokon val?
	felhaszn醠醩醨髄 閞dekl鮠j a k閟z韙鮪閘! A clearbox forr醩k骴ja nem m骴os韙hat? 
	A clearbox a k閟z韙?beleegyez閟e n閘k黮 p閚z閞t harmadik f閘nek tov醔b nem adhat?

	LICENSE:

	ClearBox can be used free for all non-commercial web pages. For commercial using, please contact with the developer:

	George Krupa
*/



var	CB_ScriptDir='clearbox';
var	CB_Language='en';



//
//	ClearBox load:
//

	var CB_Scripts = document.getElementsByTagName('script');
	for(i=0;i<CB_Scripts.length;i++){
		if (CB_Scripts[i].getAttribute('src')){
			var q=CB_Scripts[i].getAttribute('src');
			if(q.match('clearbox.js')){
				var url = q.split('clearbox.js');
				var path = url[0];
				var query = url[1].substring(1);
				var pars = query.split('&');
				for(j=0; j<pars.length; j++) {
					par = pars[j].split('=');
					switch(par[0]) {
						case 'config': {
							CB_Config = par[1];
							break;
						}
						case 'dir': {
							CB_ScriptDir = par[1];
							break;
						}
						case 'lng': {
							CB_Language = par[1];
							break;
						}
					}
				}
			}
		}
	}

	if(!CB_Config){
		var CB_Config='default';
	}

	document.write('<link rel="stylesheet" type="text/css" href="'+CB_ScriptDir+'/config/'+CB_Config+'/cb_style.css" />');
	document.write('<script type="text/javascript" src="'+CB_ScriptDir+'/config/'+CB_Config+'/cb_config.js"></script>');
	document.write('<script type="text/javascript" src="'+CB_ScriptDir+'/language/'+CB_Language+'/cb_language.js"></script>');
	document.write('<script type="text/javascript" src="'+CB_ScriptDir+'/core/cb_core.js"></script>');