import Rails from "@rails/ujs";
import html2canvas from 'html2canvas';

const tweetResults = () => {
  const results = document.querySelector('#result');
  let twitterBtn = document.querySelector('#twitter');
  const loader = document.getElementById('loading');

  function dataURLtoBlob(dataURL) {
    // Decode the dataURL
    let binary = atob(dataURL.split(',')[1]);
    // Create 8-bit unsigned array
    let array = [];
    for (let i = 0; i < binary.length; i++) {
      array.push(binary.charCodeAt(i));
    }
    // Return our Blob object
    return new Blob([new Uint8Array(array)], { type: 'image/png' });
  }

  const uploadScreenshot = () => {
    html2canvas(results, {
      backgroundColor: '#035d79cc',
      allowTaint: true,
      useCORS: true,
      proxy: 'server.js',
    }).then(canvas => {
      console.log("Screenshot for cloudinary and result model!")
      const image = canvas.toDataURL("image/png", 1.0).replace("image/png", "image/octet-stream");

      // Save in base64 image
      let file = dataURLtoBlob(image)

      let fd = new FormData();
      // Append our Canvas image file to the form data
      fd.append("image", file);

      // Append the result number to the form data
      let url = window.location.href;
      const resultId = url.split("/").pop();
      fd.append("result", resultId)

      // And send it
      Rails.ajax({
        url: "/screenshot",
        type: "POST",
        data: fd,
        processData: false,
        contentType: false,
        success: tweetImgUrl,
        error: function (error) { console.log(error) }
      });
    });
  }

  const tweetImgUrl = (data) => {
    const title = results.querySelector('h1');
    const tweetableUrl = "https://twitter.com/intent/tweet?url=" + data.url + "&text=" + encodeURIComponent(`Check our ${title.innerText} on www.de-bored.fun`);
    loader.classList.add('d-none');
    window.open(tweetableUrl, "Twitter", "height=400,width=400,resizable=1");
  };

  if (!!twitterBtn) {
    // Open the popup
    $(twitterBtn).click(function (e) {
      e.preventDefault();
      loader.classList.remove('d-none');
      uploadScreenshot();
    });
  }
}

export { tweetResults };
