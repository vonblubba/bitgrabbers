# run with:
# rake import:screenshots[true] --> publish all now
# rake import:screenshots[false] --> publish at 3 days distance (default)
namespace :import do
  desc "Import screenshots and games from mysql csv dump"
  task :screenshots, [:publish_all] => :environment do |t, args|
    CSV.open(Rails.root.join("db/import/screenshots.csv"), "r", { :col_sep => "\t" }).each_with_index do |row, i|
      #["id", "gameId", "description", "resolution00", "resolution01", "resolution02", "resolution03", "resolution04", "resolution05", "resolution06",
      #resolution07", "pageTitle", "userId", "published", "ratingSum", "votes", "createdOn", "updatedOn", "pubDate", "id", "description",
      #"name", "year", "publisher", "order", "createdOn", "updatedOn"]
      next if i == 0
      game = Game.find_by_name(row[21])

      unless game
        game = Game.new
        game.description = row[20]
        game.name = row[21]
        game.year = row[22].to_i
        game.order = 200
        next unless game.save
        puts "* Game '#{game.name}' created."
      end

      screenshot = Screenshot.find_by_title(row[11])
      unless screenshot
        screenshot = Screenshot.new
        screenshot.game = game
        screenshot.description = row[2]
        screenshot.user = User.first
        screenshot.title = row[11]
        if args[:publish_all] == 'true'
          screenshot.published = true
          screenshot.publication_date = DateTime.now - 1.days
        else
          screenshot.published = false
          screenshot.publication_date = DateTime.now + (3*i).days
        end
        File.open(Rails.root.join("db/import/images/#{row[3]}")) do |f|
          screenshot.image = f
        end

        unless screenshot.save
          File.open(Rails.root.join("db/import/images/#{row[4]}")) do |f|
            screenshot.image = f
          end
          next unless screenshot.save
        end
        puts "* Screenshot '#{screenshot.title}' created."
      end
    end
  end
end