export const showImposter = () => {
    const overlay = document.getElementById("overlay");
    
    if(!!overlay){ 
        const countdown = document.getElementById("countdown");
        const revealImposter = document.getElementById("impostor-reveal");
        const returnScreen = document.getElementById("return-screen");
        const winnerSection = document.getElementById("winner-section");
        
        const returnToScreen = () => {
            returnScreen.addEventListener("click", (e) => {
                overlay.classList.toggle("active")
                revealImposter.classList.toggle("d-none")
            })
        }

        const revealingImposter = () => {
            const timer = setInterval(() => {
                countdown.innerText -= 1
                if((parseInt(countdown.innerText)) === 0){
                    clearInterval(timer);
                    overlay.classList.toggle("active")
                    winnerSection.innerHTML = ""
                    setTimeout(() => {
                        revealImposter.classList.toggle("d-none")
                    },2000)
                }
            }, 1000)
        }
        revealingImposter();
        returnToScreen();
    }
}
