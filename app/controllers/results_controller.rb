class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show

    @instance = Instance.find(params[:instance_id])
    @votes = Vote.where(instance: @instance)
    @result = Result.find(params[:id])
    @current_user = current_or_guest_user

    # Total number of votes
    @total_votes = Vote.where(instance: @instance).count

    # Total number of voters
    @total_voters = Player.where(instance: @instance).count

    @impostor = Player.find(@instance.impostor_player_id)
    @players = Player.where(instance_id: @instance.id)

    # Tally votes in a hash, { voter_id => number of votes received }
    @vote_tally = Vote.select(:voted_player_id).where(instance_id: @instance.id).group(:voted_player_id).count(:voted_player_id)

    # Get the Highest votes in the hash
    highest_vote = @vote_tally.values.max
    highest_voted_player_id = @vote_tally.key(highest_vote)
    @highest_voted_player = Player.find(highest_voted_player_id)
    @highest_vote = @vote_tally.values.max

    @announce_winner = determine_winner()

    # Get the total of "Yes" and "No" answers of each player
    @total_answers = PlayerInput.where(instance_id: @instance.id).pluck(:player_id, :input_value)

    # Total number of "Yes" answers
    @total_yes = @total_answers.select { |k, v| v == 'Yes' }
    @total_yes_tally = @total_yes.tally
    @yes_players = []
    @total_yes_tally.each do |id, count|
      @yes_players.push(Player.find(id[0])) if count == @total_yes_tally.values.max
    end

    # Total number of "No" answers
    @total_no = @total_answers.select { |k, v| v == 'No' }
    @total_no_tally = @total_no.tally
    @no_players = []
    @total_no_tally.each do |id, count|
      @no_players.push(Player.find(id[0])) if count == @total_no_tally.values.max
    end

  end

  def determine_winner

    if ((@highest_voted_player.nickname == @impostor.nickname) &&
       (current_or_guest_user.nickname == @impostor.nickname)) ||
       ((@highest_voted_player.nickname != @impostor.nickname) &&
       (current_or_guest_user.nickname != @impostor.nickname))
          return "LOSE"
    else
      return "WON"
    end

  end

end
