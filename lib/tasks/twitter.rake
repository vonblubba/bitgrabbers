include ActionView::Helpers::TextHelper
include Rails.application.routes.url_helpers

# run with:
# rake twitter:post[false]
namespace :twitter do
  desc "Post oldest unposted screenshot on twitter"
  task :post, [:dry_run] => :environment do |t, args|
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = Rails.application.credentials.twitter[:consumer_key]
		  config.consumer_secret     = Rails.application.credentials.twitter[:consumer_secret]
		  config.access_token        = Rails.application.credentials.twitter[:access_token]
		  config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
		end

		screenshot = Screenshot.twitter_unposted.limit(1).take

		hashtags = "#bitgrabbers #screenshot ##{screenshot.game.slug.gsub('-', '')} #videogames #gaming #gamer #game"
		url = game_screenshot_url(game_id: screenshot.game, id: screenshot, :host => Rails.configuration.global_settings['base_url'])

		availalbe_chars = 270 - (hashtags.length + url.length)

		text =  truncate(screenshot.description, length: availalbe_chars, separator: ' ')

		client.update_with_media("#{text}\n\n#{url}\n\n#{hashtags}", File.open(Rails.root.join(screenshot.image.low_quality.path)))

		screenshot.twitter_posted = true
		screenshot.save
  end
end
