export const showWinner = () => {
  const winnerSection = document.getElementById("winner-section");
  const returnBtn = document.getElementById("return-screen");

    if((!!winnerSection) && (!!returnBtn)){
      const announce = winnerSection.dataset.announceWinner;
      const impostor = winnerSection.dataset.winnerId;

      let announcement = ""
      if (announce === "LOSE") {
        announcement = `<h4 class="victory-fail">You lost!</h4>`
      } else{
        announcement = `<h4 class="victory-fail">You won!</h4>`
      }

      returnBtn.addEventListener("click", (e) => {
          winnerSection.innerHTML = announcement
          const cards = document.querySelectorAll('#result-card')
          cards.forEach((card) => {
            if (card.innerText == impostor) {
              const impostorCard = card;
              impostorCard.setAttribute("id", "result-card-impostor");
              document.getElementById("impostor-label").classList.remove("d-none")
            }
          })

      })
    }

}
