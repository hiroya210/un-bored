class PlayerInputsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    # player_inputs are created after players clicks on their answers from rounds show page phase1

    @instance = Instance.find(params[:instance_id])
    @current_user = current_or_guest_user
    @round = Round.find(params[:round_id])

    # Change to phase 2 (collecting users' results)
    # line only gets executed after any player submits the first input
    @round.update(phase: 2) if @round.phase == 1

    @player_input = PlayerInput.new(
      instance_id: @instance.id,
      player: Player.find_by(instance: @instance, user: current_user), # Find the latest player that was created from the current user
      input_type: "string",
      input_value: params[:input_value],
      round_id: @round.id
    )

    if @player_input.save
      # send to channel
      RoundChannel.broadcast_to(
        @round,
        player_input: render_to_string(partial: "player_input", locals: { round: @round }),
        player_input_count: render_to_string(partial: "rounds/show_player_inputs_count", locals: { round: @round })
      )
    else
      flash[:alert] = "You already replied"
    end

    redirect_to instance_round_path(@instance, @round)
  end
end
