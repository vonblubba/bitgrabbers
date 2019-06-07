# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://bitgrabbers.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add about_path, :priority => 0.7, :changefreq => 'daily'
  add submit_path, :priority => 0.7, :changefreq => 'daily'

  Screenshot.find_each do |screenshot|
    add game_screenshot_path(game_id: screenshot.game, id: screenshot), :lastmod => screenshot.updated_at
  end

  Game.find_each do |game|
    add game_path(game), :lastmod => game.updated_at
  end

  ActsAsTaggableOn::Tag.find_each do |tag|
    add tag_path(tag), :lastmod => Time.now
  end
end
