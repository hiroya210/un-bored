export const autoFocus = () => {
  const nickNameform = document.getElementById("user_nickname");
  const joinForm = document.getElementById("passcode")
 
  if (!!joinForm){
      joinForm.addEventListener("click",(e) => {
          e.currentTarget.select();
      })
    }

  if (!!nickNameform){
      nickNameform.addEventListener("click",(e) => {
          e.currentTarget.select();
      })
    }
    
    
}