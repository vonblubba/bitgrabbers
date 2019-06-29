include ActionView::Helpers::TextHelper
include Rails.application.routes.url_helpers

# run with:
# rake facebook:post
namespace :facebook do
  desc "Post oldest unposted screenshot on facebook page"
  task :post, [:dry_run] => :environment do |t, args|
    @oauth = Koala::Facebook::OAuth.new(Rails.application.credentials.facebook[:app_id], Rails.application.credentials.facebook[:app_secret])
    app_token = @oauth.get_app_access_token

    @user_graph = Koala::Facebook::API.new(app_token)
    page_id = Rails.application.credentials.facebook[:page_id]
    pages = @user_graph.get_connections('me', 'accounts')
    byebug
    page_token = @user_graph.get_page_access_token(page_id)
    #@page_graph = Koala::Facebook::API.new(page_token)

    #screenshot = Screenshot.facebook_unposted.limit(1).take
    #hashtags = "#bitgrabbers #screenshot #videogames #gaming #gamer #game ##{screenshot.game.slug.sub('-', '')}"
    #url = game_screenshot_url(game_id: screenshot.game, id: screenshot, :host => Rails.configuration.global_settings['base_url'])
    #text =  screenshot.description
    #message = "#{text}\n\nHigh quality image here:\n#{url}\n\n#{hashtags}"

    #@page_graph.put_picture(Rails.root.join(screenshot.image.low_quality.path), {:message => message}, page_id) #post as picture with caption

    #screenshot.facebook_posted = true
    #screenshot.save
  end
end