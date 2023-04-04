
function convertTZ(date, tzString) {
    return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: tzString}));   
}

window.addEventListener("load", function () {
	errdiv = document.createElement("div");
	if (true) { //debug
		errdiv.classList.add("console");
		document.body.appendChild(errdiv);
		window.onerror = function (errorMsg, url, lineNumber, column, errorObj) {
			errdiv.innerHTML += '<br />Error: ' + errorMsg + ' Script: ' + url + ' Line: ' + lineNumber
				+ ' Column: ' + column + ' StackTrace: ' + errorObj;
		}
	}
	var wprompt = new WPrompt();
	var requestmgr = new RequestManager();
	var announcemgr = new AnnounceManager();

	requestmgr.onResponse = function (id, ok) {
		$.post("http://vrp/request", JSON.stringify({act: "response", id: id, ok: ok}));
	}
	wprompt.onClose = function () {
		$.post("http://vrp/prompt", JSON.stringify({act: "close", result: wprompt.result}));
	}

	//request config
	$.post("http://vrp/cfg", "");

	var pbars = {}
	var divs = {}
	setInterval(function () {
        const d = new Date()
        convertTZ(d, 'Europe/Bucharest'); 
        let hours = d.getHours()
        let minutes = d.getMinutes()
        minutes = minutes <= 9 ? '0' + minutes : minutes 
        hours = hours <= 9 ? '0' + hours : hours
        document.getElementById("ora").innerHTML = hours+":"+minutes+"";

    
    }, 10000);

	//progress bar ticks (25fps)
	setInterval(function () {
		for (var k in pbars) {
			pbars[k].frame(1 / 25.0 * 1000);
		}

	}, 1 / 25.0 * 1000);

	//MESSAGES
	window.addEventListener("message", function (evt) { //lua actions
		var data = evt.data;

		if (data.act == "cfg") {
			cfg = data.cfg
		}
		else if (data.act == "update_players") {
			this.document.getElementById("jucatori").innerHTML = data.playerson + "/128" + '<i class="fa-solid fa-clock"></i>'
		}
		else if (data.act == "update_id") {
			this.document.getElementById("id").innerHTML ='<strong>ID &nbsp;</strong>' + data.idjucator + '<i class="fa-solid fa-users"></i>'
		}
		else if (data.act == "update_cash") {
			this.document.getElementById("cash").innerHTML = data.banicash + '<i class="fa-solid fa-sack-dollar"></i>'
		}
		else if (data.act == "update_bank") {
			this.document.getElementById("bank").innerHTML = data.banibanca + '<i class="fa-solid fa-building-columns"></i>'
		}
		// else if (data.act == "update_hud_bani") {
		// 	if (data.value) {
		// 		$("#hline").fadeIn();
		// 		$("#bani").fadeIn();
		// 		$("#banca").fadeIn();

		// 		$("#handmoney").fadeIn();
		// 		$("#bankmoney").fadeIn();

		// 		this.document.getElementById("handmoney").innerHTML = data.handmoney + "$"
		// 		this.document.getElementById("bankmoney").innerHTML = data.bankmoney + "$"
		// 	} else {
		// 		$("#hline").fadeOut();
		// 		$("#bani").fadeOut();
		// 		$("#banca").fadeOut();

		// 		$("#handmoney").fadeIn();
		// 		$("#bankmoney").fadeIn();
		// 	}
		// }
		else if(data.act == "tickete") {
			if (data.value){
				$("#tickete").fadeIn();
				this.document.getElementById('tickete').innerHTML = '<dada style = "color: rgba(157,73,244);">'+ data.tickete +'</dada> <dada style = "color: white;">Tickete Active</dada>';
			} else {
				$("#tickete").fadeOut();
			}
		}
		// else if (data.act == "update_hud_safezone") {
		// 	if (data.value == true) {
		// 		$( "#safezone" ).fadeIn(500, function() {
		// 			$("#safezone").css("display","flex").fadeIn(100);
		// 		});
		// 	}else if (data.value == false) {
		// 		$( "#safezone" ).fadeOut(500, function() {
		// 			$("#safezone").css("display","none");
		// 		})
		// 	}
		// }
		else if (data.act == "update_hud_safezone") {
			if (data.value == true) {
				$( "#safezone" ).fadeIn(500, function() {
					$("#safezone").css("display","flex").fadeIn(100);
				});
			}else if (data.value == false) {
				$( "#safezone" ).fadeOut(500, function() {
					$("#safezone").css("display","none");
				})
			}
		}
		// //adm tickets
		else if (data.act == "remove_number_tickets") {
			if (data.toggle) {
				$("#ticketeAdmin").css("display","flex");
			}else {
				$("#ticketeAdmin").css("display","none");
			}
		}
		else if (data.act == "update_number_tickets") {
			$("#ticketeAdmin").css("display","flex");
			document.getElementById("tickete").innerHTML = data.tickets;
		}
		// // COMA
		// else if (data.act == "update_hud_coma") {
		// 	if (data.in_coma) {
		// 		$("#comaBackground" ).fadeIn(500, function() {
		// 			$("#comaBackground").css("display","block").fadeIn(100);
		// 			document.getElementById("comaTime").innerHTML = data.coma_left;
		// 		});
		// 	}else {
		// 		$("#comaBackground" ).fadeOut(500, function() {
		// 			$("#comaBackground").css("display","none");
					
		// 		});
		// 	}
		// }
		// else if (data.act == "update_hud_coma_time") {
		// 	document.getElementById("comaTime").innerHTML = data.coma_left;
		// }
		// PROGRESS BAR
		else if (data.act == "set_pbar") {
			var pbar = pbars[data.pbar.name];
			if (pbar)
				pbar.removeDom();

			pbars[data.pbar.name] = new ProgressBar(data.pbar);
			pbars[data.pbar.name].addDom();
		}
		else if (data.act == "set_pbar_val") {
			var pbar = pbars[data.name];
			if (pbar)
				pbar.setValue(data.value);
		}
		else if (data.act == "set_pbar_text") {
			var pbar = pbars[data.name];
			if (pbar)
				pbar.setText(data.text);
		}
		else if (data.act == "remove_pbar") {
			var pbar = pbars[data.name]
			if (pbar) {
				pbar.removeDom();
				delete pbars[data.name];
			}
		}
		// PROMPT
		else if (data.act == "prompt") {
			wprompt.open(data.title, data.text);
		}
		// REQUEST
		else if (data.act == "request") {
			requestmgr.addRequest(data.id, data.text, data.time);
		}
		// ANNOUNCE
		else if (data.act == "announce") {
			announcemgr.addAnnounce(data.background, data.content);
		}
		// DIV
		else if (data.act == "set_div") {
			var div = divs[data.name];
			if (div)
				div.removeDom();

			divs[data.name] = new Div(data)
			divs[data.name].addDom();
		}
		else if (data.act == "set_div_css") {
			var div = divs[data.name];
			if (div)
				div.setCss(data.css);
		}
		else if (data.act == "set_div_content") {
			var div = divs[data.name];
			if (div)
				div.setContent(data.content);
		}
		else if (data.act == "div_execjs") {
			var div = divs[data.name];
			if (div)
				div.executeJS(data.js);
		}
		else if (data.act == "remove_div") {
			var div = divs[data.name];
			if (div)
				div.removeDom();

			delete divs[data.name];
		}
		// CONTROLS
		else if (data.act == "event") { //EVENTS
			if (data.event == "UP") {
				/*if (!wprompt.opened)
					current_menu.moveUp();*/
			}
			else if (data.event == "DOWN") {
				/*if (!wprompt.opened)
					current_menu.moveDown();*/
			}
			else if (data.event == "LEFT") {
				/*if (!wprompt.opened)
					current_menu.valid(-1);*/
			}
			else if (data.event == "RIGHT") {
				/*if (!wprompt.opened)
					current_menu.valid(1);*/
			}
			else if (data.event == "SELECT") {
				/*if (!wprompt.opened)
					current_menu.valid(0);*/
			}
			else if (data.event == "CANCEL") {
				if (wprompt.opened)
					wprompt.close();
				/*else
					current_menu.close();*/

			}
			else if (data.event == "F5") {
				requestmgr.respond(true);
			}
			else if (data.event == "F6") {
				requestmgr.respond(false);
			}
		}
	});
});