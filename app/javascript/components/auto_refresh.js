export const updateDiv = () => { 
    const instance = document.getElementById("instance")
    const updateThis = document.getElementById("updateThis")
    const playerInputs = document.getElementById("player-input-count");

    if (!!updateThis){
        setInterval(() => {
            console.log("refreshing..")
            $( "#updateThis" ).load(window.location.href + " #updateThis" );
    
        }, 1000)
    }

    if(!!playerInputs){
        setInterval(() => {
            console.log("refreshing..")
            $( "#player-input-count" ).load(window.location.href + " #player-input-count" );
    
        }, 1000)
    }

}