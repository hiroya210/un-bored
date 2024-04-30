export const countdownTimer = () => {
    const timer = document.getElementById("timer");
    const ready = document.getElementById("ready");
    const time = document.getElementById("time");
    const newRoundBtn = document.getElementById("new_round");
    
    const showTimer = () => {
        setTimeout(() => {
            timer.classList.remove("d-none")
        }, 4000);
    }
    
    const countdownStart = () => {
        time.innerText = 9
        setInterval(() => {
            (time.innerText -= 1)

        if ((parseInt(time.innerText)) === 1){
            clearInterval();
            newRoundBtn.submit();
        }
        }, 1000)
    }
    
    const showReady = () => {
        setTimeout(() => {
            ready.classList.remove("d-none")
        },3000)

        showTimer();
        countdownStart();
    }
    
    if(!!ready){ showReady(); }
}