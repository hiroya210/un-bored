import consumer from "./consumer";

const initInstanceChannel = () => {
  const instanceContainer = document.getElementById("instance")

  if (instanceContainer) {
    const playerList = document.getElementById("player-list")
    const gameSettings = document.getElementById("game-config")
    const playerCount = document.getElementById("max-player-count")
    const currentPlayerCount = document.getElementById("min-player-count")
    const gameIndex = document.getElementById("de-bored-games");
    const instance_id = instanceContainer.dataset.instanceId;
    const host_id = instanceContainer.dataset.hostId;
    const host_name = instanceContainer.dataset.hostName;
    const player_id = instanceContainer.dataset.playerId
    const player_name = instanceContainer.dataset.playerName

    consumer.subscriptions.create({ channel: "InstanceChannel", id :instance_id }, {
      connected() {
        console.log(`PLAYER ID: ${player_id} HOST ID: ${host_id} PLAYER NAME: ${player_name} HOST NAME: ${host_name}`)
      },

      disconnected() {
        console.log("InstanceChannel disconnected");
        `${player_name} has left the Instance Channel ${instance_id}`
      },

      received(data) {
        console.log(data)
        // to redirect all subscribers except host after clicking start game, host is redirected via controller
        if (data.head == 303 && data.path) {
          window.location.pathname = data.path;
        }
        // console.log("InstanceChannel received", data);
        if (data.waiting_page){
          const notice_player =
              `<div class="alert alert-success alert-dismissible fade show" role="alert">
              <strong>${data.user}</strong> has joined the lobby <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span></button></div>`

          playerList.innerHTML = data.page;
          currentPlayerCount.innerHTML = data.count;
          instanceContainer.insertAdjacentHTML("beforebegin", notice_player);
          const playersSelector = document.getElementById("instance_max_players");
          playersSelector.setAttribute("min", currentPlayerCount.innerHTML);
        }
        if (data.head == 101){
          const player_left =
          `<div class="alert alert-warning alert-dismissible fade show" role="alert">
          <strong>${data.user}</strong> has left the lobby <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span></button></div>`

          playerList.innerHTML = data.page;
          currentPlayerCount.innerHTML = data.count;
          instanceContainer.insertAdjacentHTML("beforebegin", player_left);
        }
        if (data.game_settings){
          const update_game =
              `<div class="alert alert-success alert-dismissible fade show" role="alert">Game Settings Updated<button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span></button></div>`
          gameSettings.innerHTML = data.page;
          playerCount.innerHTML = data.count;
          instanceContainer.insertAdjacentHTML("beforeend", update_game);
        }

        if (data.head == 100){
          window.location.pathname = data.path;
          setTimeout(() => {
            
          })
        }
      }
    });
  }
}

export { initInstanceChannel };
