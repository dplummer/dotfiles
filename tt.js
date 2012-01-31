(function() {
    if (document.location.host.indexOf("turntable.fm")==-1){
        document.location.href= "http://turntable.fm";
    }

    var debug = "";
    var roomManagerName;
    var turntableModelName;
    var toggleAutoJoinButton;
    var toggleAutoAwesomeButton;
    var toggleAutoChangeButton
    var joinOn = false;
    var awesomeOn = false;
    var avatarOn = false;
    var avatarOnInterval;
    var joinInterval;
    var awesomeInterval;
    var roomUsersById;
    var userInfo;
    var awesomesColumn;
    var votesColumn;
    var lameVoteList = "";
    var awesomeVoteList = "";
    var totalListeners;
    findObfuscatedObjects();
    if (roomManagerName && turntableModelName){
        init();
    } else {
        somethingBroke();
    }
    
    function findObfuscatedObjects(){
        for (var prop in this){ 
            if (this[prop]["callback"]){ 
                roomManagerName = prop;
                break; 
            } 
        }
        for (var key in turntable){
            if (turntable[key] && turntable[key]["users"]){
                turntableModelName = key;
                break;
            }
        }
    }
    function getRoomManager(){
        //retreived this way as value will change when changing rooms
        return window[roomManagerName];
    }
    function getTurntableModel(){
        //retreived this way as value will change when changing rooms
        return window["turntable"][turntableModelName];
    }
    

    function somethingBroke(){
        if (document.location.host.indexOf("turntable.fm")==-1){
            alert("The TT script broke. :(");
        } else {
            alert("Try clicking this while in a turntable.fm room");
        }
    }

    function init(){
        userInfo = turntable.user; //displayName, djPoints, id, getUserInfo
        //playlist = turntable.playlist.files
        //roomUsersById = rm.users; //name points userid
        createMenu();
    }

    function createMenu(){
        toggleAutoJoinButton = document.createElement("button");
        toggleAutoJoinButton.style.cssText = 'position: absolute; right: 1px; top: 1px; border: 1px solid #999999; z-index:999';  
        toggleAutoJoinButton.addEventListener("click", function(){
           toggleAutoJoin(!joinOn); 
        }, false);  
        document.body.appendChild(toggleAutoJoinButton);

        toggleAutoAwesomeButton = document.createElement("button");
        toggleAutoAwesomeButton.style.cssText = 'position: absolute; right: 1px; top: 21px; border: 1px solid #999999; z-index:998';  
        toggleAutoAwesomeButton.addEventListener("click", function(){
           toggleAutoAwesome(!awesomeOn); 
        }, false);  
        document.body.appendChild(toggleAutoAwesomeButton);
        
        toggleAutoChangeButton = document.createElement("button");
        toggleAutoChangeButton.style.cssText = 'position: absolute; right: 1px; top: 41px; border: 1px solid #999999; z-index:998';  
        toggleAutoChangeButton.addEventListener("click", function(){
           toggleAutoChangeAvatar(!avatarOn); 
        }, false);  
        document.body.appendChild(toggleAutoChangeButton);

        toggleAutoJoin(false);
        toggleAutoAwesome(false);
        toggleAutoChangeAvatar(false);

        votesColumn = document.createElement("text");
        votesColumn.style.cssText = 'position: absolute; width: 120px; right: 1px; top: 71px; bottom: 10px; z-index:997; color:#ffffff; font-size: 10px';
        document.body.appendChild(votesColumn);

        turntable.addEventListener("message", function(evt){
            if (evt.hasOwnProperty("msgid")){
                //console.log("message: "+evt.msgid, evt);
                if (evt.room){
                    try {
                        findObfuscatedObjects();
                        var upvotes = evt.room.metadata.upvotes;
                        var downvotes = evt.room.metadata.downvotes;
                        resetVoteList();
                        var votelog = evt.room.metadata.votelog;
                        for (var i = 0; i<votelog.length; i++){
                            addVote(votelog[i][0], votelog[i][1]);
                        }
                        updateVoteCounter(upvotes, downvotes);
                    } catch(er){
                        console.log("er: "+er, er);
                    }
                } else if (evt.err){
                    console.log("Turntable error: "+evt.err); //"user not in room"
                }
            } else {
                if (evt.command){
                    switch (evt.command){
                        case "update_votes":
                            var meta = evt.room.metadata;
                            var upvotes = meta.upvotes;
                            var downvotes = meta.downvotes;
                            totalListeners = meta.listeners-1;
                            var voterid = meta.votelog[0][0];
                            var votervote = meta.votelog[0][1];
                            addVote(voterid, votervote);
                            updateVoteCounter(upvotes, downvotes);
                            if (debug && getTurntableModel() && getTurntableModel().users && getTurntableModel().users[voterid]) console.log("user \""+getTurntableModel().users[voterid].name+"\" voted "+votervote);
                            break;
                        case "newsong":
                            resetVoteList();
                            if (awesomeOn) setTimeout(function(){ awesomeSong(); }, 5000+(Math.round(20000*Math.random())));
                            break;
                        case "rm_dj":
                            if (joinOn) checkForDJSpot();
                            break;
                        case "deregistered":
                            if (debug) console.log("user \""+evt.user[0].name+"\" left");
                            break;
                        case "registered":
                            if (debug) console.log("user \""+evt.user[0].name+"\" joined");
                            break;
                        case "speak":
                            if (debug) console.log("user \""+evt.name+"\" said: "+text);
                            break;
                        default:
                            if (debug) console.log("command: "+evt.command+" not recognised", evt);
                    }
                }
            }
        });
        if (debug){    
            turntable.addEventListener("auth", function(evt){ console.log("auth: "+evt, evt) });
            turntable.addEventListener("reconnect", function(evt){ console.log("reconnect: "+evt, evt) });
            //turntable.addEventListener("soundstart", function(evt){ console.log("soundstart: "+evt, evt) });
            //turntable.addEventListener("soundfinish", function(evt){ console.log("soundfinish: "+evt, evt) });
        }
    }
    
    function resetVoteList(){
        awesomeVoteList = "";
        lameVoteList = "";
        updateVoteCounter(0, 0);
    }
    function addVote(voterid, votervote){
        //if (debug) console.log("adding vote: "+voterid+" vote: "+votervote);
        try {
            var currentvoter = getTurntableModel().users[voterid].name;
            currentvoter = "<span class='voter' onmouseover='"+roomManagerName+".toggle_listener(\""+voterid+"\"); this.style.textDecoration=\"underline\"' onmouseout='"+roomManagerName+".toggle_listener(\""+voterid+"\"); this.style.textDecoration=\"none\"' onclick='"+roomManagerName+".callback(\"profile\", \""+voterid+"\");'>"+currentvoter+"</span>";
            if (votervote=="up"){
                awesomeVoteList+="<br/>"+currentvoter;
            } else {
                lameVoteList+="<br/>"+currentvoter;
            }
        } catch(er){
        }
    }

    function updateVoteCounter(upvotes, downvotes){
        var totalvotes = upvotes+downvotes;
        var percentupvotes = totalvotes ? Math.round((upvotes/totalvotes)*100) : 0;
        var percentuproom = totalListeners ? Math.round((upvotes/totalListeners)*100) : 0;
        var percentdownvotes = totalvotes ? Math.round((downvotes/totalvotes)*100) : 0;
        var percentdownroom = totalListeners ? Math.round((downvotes/totalListeners)*100) : 0;
        //awesomesColumn.innerHTML = "Awesomes: "+upvotes+" ("+percentup+"%)"+awesomeVoteList;
        //votesColumn.innerHTML = "Lames: "+downvotes+" ("+percentdown+"%)"+lameVoteList;
        var innerHTML = "AWESOMES: "+upvotes+" <br/>"+percentupvotes+"% votes - "+percentuproom+"% room";
        if (upvotes) innerHTML+="<br/><br/>Voted awesome:"+awesomeVoteList;
        innerHTML+="<br/><br/>LAMES: "+downvotes+" <br/>"+percentdownvotes+"% votes - "+percentdownroom+"% room";
        if (downvotes) innerHTML+="<br/><br/>Voted lame:"+lameVoteList;
        votesColumn.innerHTML = innerHTML;

    }

    function toggleAutoJoin(value){
        joinOn = value;
        if (joinInterval) clearInterval(joinInterval);
        if (joinOn){
            joinInterval = setInterval(checkForDJSpot, 400);
        }
        toggleAutoJoinButton.innerHTML = "Grab next DJ Spot: "+(joinOn ? "On" : "Off");
    }
    
    function toggleAutoChangeAvatar(value){
        avatarOn = value;
        if (avatarOnInterval) clearInterval(avatarOnInterval);
        if (avatarOn){
            avatarOnInterval = setInterval(changeAvatar, 2000);
        }
        toggleAutoChangeButton.innerHTML = "Auto Change Avatar: "+(avatarOn ? "On" : "Off");
    }
    
    var avatar = 0;
    var apiMethod;
    function changeAvatar(){
        //avatar = Math.floor(Math.random()*23)+1;
        //62-74
        avatar = Math.floor(Math.random()*12)+62;
        if (!apiMethod){
            var notAPI = {
                syncServerClock: true,
                main: true,
                flushUnsentMessages: true,
                setSocketAddr: true,
                socketConnected: true,
                socketKeepAlive: true,
                socketLog: true,
                socketDumpLog: true,
                initIdleChecker: true,
                idleTime: true,
                checkIdle: true,
                socketReconnected: true,
                pingSocket: true,
                closeSocket: true,
                addEventListener: true,
                removeEventListener: true,
                dispatchEvent: true,
                addIdleListener: true,
                removeIdleListener: true,
                setPage: true,
                reloadPage: true,
                initFavorites: true,
                hashMod: true,
                getHashedAddr: true,
                numRecentPendingCalls: true,
                whenSocketConnected: true,
                messageReceived: true,
                logMessage: true,
                randomRoom: true,
                showWelcome: true,
                die: true,
                showAlert: true,
                serverNow: true,
                seedPRNG: true
            }
            for (var prop in turntable){
                if (typeof turntable[prop]=="function" && !notAPI[prop]){
                    apiMethod = turntable[prop];
                    return;
                }
            }
            if (!apiMethod){
                alert("Sorry this feature is currently broken");
                toggleAutoChangeAvatar(false);
                return;
            }
        }
        apiMethod({
            api: "user.set_avatar",
            avatarid: avatar
        }, function (b) {
            if (b.success) {
                turntable.dispatchEvent("avatarchange");
            }
        });
    }
    
    function toggleAutoAwesome(value){
        awesomeOn = value;
        awesomeSong();
        toggleAutoAwesomeButton.innerHTML = "Auto Awesome songs: "+(awesomeOn ? "On" : "Off");
    }
    function awesomeSong(){
        if (lameVoteList.indexOf(userInfo.displayName)==-1 && awesomeVoteList.indexOf(userInfo.displayName)==-1){
            getRoomManager().callback("upvote");
        }
    }

    function checkForDJSpot(){
        var amDJ = false;
        var rm = getRoomManager();
        for (var key in rm.djs){
            if (rm.djs[key] && rm.djs[key][0]==rm.myuserid){
                amDJ = true;
                toggleAutoJoin(false);
                console.log("You're a DJ");
                break;
            }
        }
        var hasEmptySpot = !Boolean(rm.djs[rm.dj_spots-1]);
        if (hasEmptySpot){ 
            //make sure we're not already there
            if (!amDJ){
                rm.callback("become_dj")
                turntablePlayer.playEphemeral(UI_SOUND_CHAT, true);
                setTimeout(function(){ turntablePlayer.playEphemeral(UI_SOUND_CHAT, true) }, 500);
                setTimeout(function(){ turntablePlayer.playEphemeral(UI_SOUND_CHAT, true) }, 1000);
            }
        } 
    }
})();


