xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Bitgrabbers"
    xml.description "Videogame screenshots taken by videogame lovers. Because we strongly believe that videogames CAN be a form of art."
    xml.link root_url

    @screenshots.each do |screenshot|
      xml.item do
        xml.title screenshot.title
        xml.description screenshot.description
        xml.pubDate screenshot.publication_date.to_s(:rfc822)
        xml.link game_screenshot_url(game_id: screenshot.game, id: screenshot)
        xml.guid game_screenshot_url(game_id: screenshot.game, id: screenshot)
      end
    end
  end
end