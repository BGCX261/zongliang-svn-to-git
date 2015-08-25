var browser = navigator.appName;
var alp = 0;
var sH = 0;
var info = document.getElementById("win");
var infobg = document.getElementById("winbg");

function cp() {
    infobg.style.visibility = "visible";
    info.style.visibility = "visible";
    if (browser.indexOf("Internet Explorer") != -1) {
        info.style.filter = "alpha(opacity=0)";
    } else {
        info.style.opacity = 0;
    }
    show = setInterval(proShow, 10);
}

function proShow() {
    alp += 10;
    if (browser.indexOf("Internet Explorer") != -1) {
        info.style.filter = "alpha(opacity=" + alp + ")";
    } else {
        info.style.opacity = alp / 100;
    }
    if (alp >= 100) {
        clearInterval(show);
    }
}

function proHid() {
    alp -= 20;
    if (browser.indexOf("Internet Explorer") != -1) {
        info.style.filter = "alpha(opacity=" + alp + ")";
    } else {
        info.style.opacity = alp / 100;
    }
    if (alp <= 0) {
        info.style.visibility = "hidden";
        clearInterval(hid);
        infobg.style.visibility = "hidden";
    }
}

function cp_user() {
    infobg.style.visibility = "visible";
    info.style.visibility = "visible";
    if (browser.indexOf("Internet Explorer") != -1) {
        info.style.filter = "alpha(opacity=0)";
    } else {
        info.style.opacity = 0;
    }
    show = setInterval(proShow_user, 10);
}

function proShow_user() {
    alp += 10;
    if (browser.indexOf("Internet Explorer") != -1) {
        info.style.filter = "alpha(opacity=" + alp + ")";
    } else {
        info.style.opacity = alp / 100;
    }
    if (alp >= 100) {
        clearInterval(show);
        for (var i = 0; i <= document.getElementsByTagName("select").length - 1; i++) {
            document.getElementsByTagName("select")[i].style.display = "none";
        }
    }
}

function proHid_user() {
    alp -= 20;
    if (browser.indexOf("Internet Explorer") != -1) {
        info.style.filter = "alpha(opacity=" + alp + ")";
    } else {
        info.style.opacity = alp / 100;
    }
    if (alp <= 0) {
        info.style.visibility = "hidden";
        clearInterval(hid);
        infobg.style.visibility = "hidden";
        for (var i = 0; i <= document.getElementsByTagName("select").length - 1; i++) {
            document.getElementsByTagName("select")[i].style.display = "inline";
        }
    }
}