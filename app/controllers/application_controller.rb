class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_forgery_protection

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :nickname, :email])
  end

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        # logging_in no need for now
        # reload guest_user to prevent caching problems before destruction
        # guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  def reference_user_avatar_to_player(player_id, user_id)
    user_avatar = ActiveStorage::Attachment.find_by(record_type: "User", record_id: user_id)

    player_avatar = ActiveStorage::Attachment.new
    player_avatar.name = user_avatar.name
    player_avatar.record_type = "Player"
    player_avatar.record_id = player_id
    player_avatar.blob_id = user_avatar.blob_id
    player_avatar.save!
  end

  private

  def create_guest_user
    player_prefix = "Player" << %w(X Y Z N A B C D E).sample
    u = User.new(username: "#{player_prefix}#{Time.now.to_i.to_s}" , guest: true) # Time.now to always be unique
    u.nickname = player_prefix << rand(0..999).to_s.rjust(3, '0')                 # rjust to add zeroes to the left in case number is below 100
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    u
  end
end
