// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "chartkick/chart.js"

// Internal imports, e.g:
import { showTaps }             from "../components/show_taps";
import { initInstanceChannel }  from '../channels/instance_channel';
import { highlighter }          from "../plugins/rough_notation";
import { initRoundCable }       from '../channels/round_channel';
import { autoClick }            from "../components/popup";
import { countdownTimer }       from "../components/countdown_timer";
import { autoFocus }            from "../components/auto_focus";
import { updateDiv }            from "../components/auto_refresh";
import { initResultCable }      from "../channels/result_channel";
import { tweetResults }         from "../components/screenshot";
import { showImposter }         from "../components/show_imposter";
import { showWinner }           from "../components/show_winner";

// next 3 lines is from https://fontsource.org/fonts
import "@fontsource/roboto";
import "@fontsource/play";
import "@fontsource/dosis";

document.addEventListener('turbolinks:load', () => {
  // showTaps();
  initInstanceChannel();
  initRoundCable();
  initResultCable();
  autoClick();
  highlighter();
  countdownTimer();
  autoFocus();
  updateDiv();
  tweetResults();
  showImposter();
  showWinner();
});
