class RoundsController < ApplicationController
  skip_before_action :authenticate_user!

  # Start creating a round after Start button or Next Question button has been clicked
  def create
    @instance = Instance.find(params[:instance_id])
    next_round_number = determine_next_round(@instance)

    if next_round_number.zero?
      # this truthy block means the game has just started and it should start with round zero showing if players are impostor or not

      # in memory @round is going to have: number: 0, game_content_id: nil, instance_id: 1, phase: 1
      @round = Round.new(instance: @instance)
      forced_impostor_nickname = "cedrine"
      impostor_player_id = generate_impostor(@instance, forced_impostor_nickname)
      @instance.update(impostor_player_id: impostor_player_id, status: "ongoing")

      if @round.save
        # redirect all subscribers to round zero except host 
        InstanceChannel.broadcast_to(
          @instance,
          head: 303,
          path: instance_round_path(@instance, @round)
        )
      end

      # to also redirect host to the next page
      redirect_to instance_round_path(@instance, @round)
    else
      # this falsy block means the game already went through round zero

      @round = Round.new(instance: @instance, number: next_round_number)
      @round = generate_unique_question(@round)

      # get the previous round of the instance, users from that action cable needs to be redirected
      last_round = Round.where(instance_id: @instance).order(id: :desc).limit(1).first

      if @round.save
        RoundChannel.broadcast_to(
          last_round,
          head: 303,
          path: instance_round_path(@instance, @round)
        )
      end

      # to also redirect host to the next page
      redirect_to instance_round_path(@instance, @round)
    end
  end

  def show
    @current_user = current_or_guest_user
    @instance = Instance.find(params[:instance_id])
    @game_id = @instance.game_id
    @round = Round.find(params[:id])
    @player_inputs = PlayerInput.where(round_id: @round.id)
    
    if @round.number.zero?
      # needed to know who the impostor is on round zero
      @current_player_is_impostor = (Player.find_by(instance: @instance, user: @current_user).id == @instance.impostor_player_id)
    else
      # only generate contents to non round zero rounds
      @game_content = GameContent.find(@round.game_content_id)
    end
  end

  private

  def determine_next_round(instance)
    # `first` is needed to take the object out of the array caused by using `where`
    last_round = Round.where(instance: instance).order(number: :desc).limit(1).first

    # true means game just started so must start with round zero
    # false means just increment the last round number
    last_round.nil? ? 0 : last_round.number + 1
  end

  def generate_unique_question(round)
    game = Game.find(round.instance.game_id)
    game_contents_array = game.game_contents
    game_contents_ids = game_contents_array.map(&:id)

    loop do
      if game_contents_array.empty?
        game_contents_array = game.game_contents
        game_contents_ids = game_contents_array.map(&:id)
      end

      round.game_content_id = game_contents_ids.shuffle!.pop
      break if round.valid?
    end

    round
  end

  def generate_impostor(instance, nickname)
    player_ids = Player.where(instance: instance).pluck(:id)

    # impostor is a random player if force_impostor returns nil
    force_impostor(instance, nickname) || player_ids.sample
  end

  def force_impostor(instance, nickname)
    user_ids = Player.where(instance: instance).pluck(:user_id)
    # users = user_ids.map { |user_id| User.find(user_id) }
    impostor = nil

    user_ids.each do |user_id|
      # find match regardless of casing
      if User.find(user_id).nickname.downcase == nickname.downcase
        impostor = Player.find_by(instance: instance, user_id: user_id).id
        break
      end
    end

    # if nil then there is no player with the given nickname
    impostor
  end
end
