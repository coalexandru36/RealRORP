window.addEventListener("message", e => {
    let data = e.data;
    if (data.action == 'updateDeathscreen'){
        switch (data.event){
            case "update": $("#remainingSeconds").text(data.seconds); break;
            case "showDeathscreen": $(".deathscreen").fadeIn(); break;
            case "closeDeathscreen": $(".deathscreen").fadeOut(); break;
            case 'canRespawn': $(".info-e").fadeIn(); break;
            case 'disableRespawn': $(".info-e").fadeOut(); break;
        }
    }
    if(data.sendAdminAnnouncement){
        document.getElementById("adminAnnouncementContainer").style.display = "block";
        this.document.getElementById("admAnnName").innerHTML = data.admAnnName;
        this.document.getElementById("admAnnId").innerHTML = data.admAnnId;
        this.document.getElementById("admAnnMessage").innerHTML = data.admAnnMessage;
        setTimeout(function(){
            $("#adminAnnouncementContainer").fadeOut();
        }, 10000);
    }
    if(data.announcement){
        document.getElementById("announcement").style.display = "block";
        this.document.getElementById("annSenderphone").innerHTML = data.annSenderphone;
        this.document.getElementById("annMessage").innerHTML = data.annMessage;
        setTimeout(function(){
            $("#announcement").fadeOut();
        }, 10000);
    }
});

