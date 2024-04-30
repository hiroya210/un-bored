import { annotate } from 'rough-notation';
// Or using unpkg
// import { annotate } from 'https://unpkg.com/rough-notation?module';

export const highlighter = () => {
  const logo = document.getElementById("de-bored-logo")
  
    if (!!logo) {
      const targetLogo = document.querySelector('#svg-logo');
      const svgLogo = document.querySelector(".path");
      const deBoredQuote = document.querySelector(".de-bored-quote");
      const silence = document.getElementById("silence");
      const playNow = document.getElementById("play-now")

      const roughNotation = () => {
          const annotation = annotate(targetLogo, 
              { 
                  type: 'highlight', 
                  color: "#52D75F",
                  animationDuration: 2000,
                  strokeWidth: 6,
                  iterations: 3,
                  padding: 20
              });
          annotation.show()
      
      }
      const roughNotation2 = () => {
          const annotation = annotate(silence, 
              { 
                  type: 'crossed-off', 
                  color: "black",
                  strokeWidth: 1,
                  iterations: 3,
              });
              setTimeout(() => { annotation.show() }, 2700 )
              
          }
          
          svgLogo.addEventListener("animationend", (e) => {
              e.currentTarget.style.fill = "#364ec9";
              roughNotation();
              deBoredQuote.classList.add("active");
              roughNotation2();
              deBoredQuote.classList.add("active");
              setTimeout(() => {
                playNow.classList.remove("d-none");
              }, 3000)
    
      });
    }
    
  }