function checkTodo(id)
{
	new Ajax(baseUrl + '/todo/check/' + id + '/', {onComplete: function(request){updateNotDone(); moveRow('action-' + id);}, postBody: ' '}).request();
}

function deleteTodo(id)
{
	new Ajax(baseUrl + '/todo/delete/' + id + '/', {onComplete:function(request){updateNotDone(); moveRow('action-' + id);}, method: 'post', postBody: ' '}).request();
}

function updateNotDone()
{
	new Ajax(baseUrl + "/not_done/", {method: 'get', update:$('not_done')}).request();
	return false;
}

function Today()
{
	now = new Date();
	document.forms[0].due.value = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
}

function Tomorrow()
{
	now = new Date();
	now.setDate(now.getDate() + 1);

	document.forms[0].due.value = now.getFullYear() + "-" + (now.getMonth() +1) + "-" + now.getDate();
}

function toggleAll(itemname,state)
{
	tmp = document.getElementsByTagName('div');
	for (i=0;i<tmp.length;i++)
	{
		if (tmp[i].className == itemname) tmp[i].style.display = state;
	}
}

function toggleAllImages()
{
	var cookies = document.cookie.split(';');

	for(var i = 0; i < cookies.length; i++)
	{
		var str = cookies[i].split('=')[0];

		if(str.indexOf('toggle_context_') != -1)
		{
			var id = str.split('_')[2];
			if(getCookie(str) == 'collapsed')
			{
				toggle('c'+id);
				toggleImage('toggle_context_'+id);
			}
		}
	}
}

function toggle(idname) 
{
document.getElementById(idname).style.display = (document.getElementById(idname).style.display == 'none') ? 'block' : 'none';
}

function toggleImage(idname)
{
	if(document.images)
	{
		if(document[idname].src.indexOf('collapse.png') != -1)
		{
			document[idname].src = 'img/expand.png';
			SetCookie(idname, "collapsed");
		}
		else
		{
			document[idname].src = 'img/collapse.png';
			SetCookie(idname, "expanded");
		}
	}
}

function SetCookie (name, value) {
	var argv = SetCookie.arguments;
	var argc = SetCookie.arguments.length;
	var expires = (argc > 2) ? argv[2] : null;
	var path = (argc > 3) ? argv[3] : null;
	var domain = (argc > 4) ? argv[4] : null;
	var secure = (argc > 5) ? argv[5] : false;
	document.cookie = name + "=" + escape (value) +
	((expires == null) ? "" : ("; expires=" +
	expires.toGMTString())) +
	((path == null) ? "" : ("; path=" + path)) +
	((domain == null) ? "" : ("; domain=" + domain)) +
	((secure == true) ? "; secure" : "");
}

var bikky = document.cookie;

  function getCookie(name) { // use: getCookie("name");
    var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1; // first character
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length; // last character
    return unescape(bikky.substring(index, endstr));
  }

  // Move item from uncompleted to completed
// Many thanks to Michelle at PXL8 for a great tutorial:
// <http://www.pxl8.com/appendChild.html>
function moveRow(id){
  // -- get the table row correstponding to the selected item
  var m1 = document.getElementById(id);
  if (m1)
  // -- append it to the 1st tbody of table id="holding"
  document.getElementById('holding').getElementsByTagName('tbody')[0].appendChild(m1);
}


function updateDate(objDate)
{
	return true;
}

window.addEvent('load', function() {
	//placeholder
});

