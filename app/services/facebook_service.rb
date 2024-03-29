class FacebookService
  def self.post(screenshot_id)
    @oauth = Koala::Facebook::OAuth.new(Rails.application.credentials.facebook[:app_id], Rails.application.credentials.facebook[:app_secret])
    app_token = @oauth.get_app_access_token
    user_token = User.find_by_email("oscar.riva@gmail.com").token

    @user_graph = Koala::Facebook::API.new(user_token)
    page_id = Rails.application.credentials.facebook[:page_id]
    page_token = @user_graph.get_page_access_token(page_id)
    @page_graph = Koala::Facebook::API.new(page_token)

    screenshot = Screenshot.find(screenshot_id)
    hashtags = "#bitgrabbers #screenshot #videogames #gaming #gamer #game ##{screenshot.game.slug.sub('-', '')}"
    url = "#{Rails.configuration.global_settings['base_url']}/games/#{screenshot.game.slug}/screenshots/#{screenshot.slug}"
    text =  screenshot.description
    message = "#{text}\n\nHigh quality image here:\n#{url}\n\n#{hashtags}"
    File.open(screenshot.image.low_quality.path) do |file|
        @page_graph.put_picture(file, "image/jpeg", {:message => message}, page_id) #post as picture with caption
    end
  end
end