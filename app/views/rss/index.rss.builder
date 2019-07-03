xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Bitgrabbers"
    xml.description "Videogame screenshots taken by videogame lovers. Because we strongly believe that videogames CAN be a form of art."
    xml.link root_url
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => rss_feed_url(:format => :rss)

    @screenshots.each do |screenshot|
      xml.item do
        xml.title screenshot.title
        xml.description screenshot.description
        xml.image "#{Rails.configuration.global_settings['base_url']}#{screenshot.image.big_thumb.url}"
        xml.pubDate screenshot.publication_date.to_s(:rfc822)
        xml.link game_screenshot_url(game_id: screenshot.game, id: screenshot)
        xml.guid game_screenshot_url(game_id: screenshot.game, id: screenshot)
      end
    end
  end
end