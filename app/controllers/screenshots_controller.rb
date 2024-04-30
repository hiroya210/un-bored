class ScreenshotsController < ApplicationController
  skip_before_action :authenticate_user!

  def save
    require "shorturl"
    result = Result.find(params[:result])

    # Upload blob to cloudinary/attach to results?
    cloudinary_response = Cloudinary::Uploader.upload(params[:image])
    cloudinary_url = cloudinary_response["secure_url"]
    file = URI.open(cloudinary_url)
    result.photo.attach(io: file, filename: "#{result.id}_results.png", content_type: 'image/png')

    # Url_for result.photo
    render json: { url: ShortURL.shorten(cloudinary_url, :tinyurl) }
  end
end
