nsp = 'Old browser!';
dl = document.layers;
oe = window.opera ? 1 : 0;
da = document.all && !oe;
ge = document.getElementById;
ws = window.sidebar ? true: false;
tN = navigator.userAgent.toLowerCase();
izN = tN.indexOf('netscape') >= 0 ? true: false;
zis = tN.indexOf('msie 7') >= 0 ? true: false;
zis8 = tN.indexOf('msie 8') >= 0 ? true: false;
zis |= zis8;
if (ws && !izN) {
    quogl = 'iuy'
};
var msg = '';
function nem() {
    return true
};
window.onerror = nem;
zOF = window.location.protocol.indexOf("file") != -1 ? true: false;
i7f = zis && !zOF ? true: false;
if (da) {
    document.ondragstart = function() {
        return false
    };
    function cIE() { (msg);
        return false
    };
    function cc() {
        //document.oncontextmenu = cIE;
        setTimeout("cc()", 200)
    };
    cc()
};
function cNS(e) {
    if (dl || ws) {
        if (e.which == 2 || e.which == 3) { (msg);
            return false
        }
    }
};
if (dl) {
    document.captureEvents(Event.MOUSEDOWN);
    document.onmousedown = cNS
} else {
    document.onmouseup = cNS
};
//document.oncontextmenu = new Function("return false");
if (oe) {
    function ro(e) {
        if (event.button == 2) {
            alert(' ');
            return 0
        };
        return true
    };
    document.onmousedown = ro
};
if (zis8) {
    window.attachEvent('onload', qy9)
};
