# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

if Rails.env.development? && User.find_by_email('oscar.riva@gmail.com').nil?
  User.create!(
    email: 'oscar.riva@gmail.com',
    password: 'pwdfuffa',
    password_confirmation: 'pwdfuffa'
  )
end

10.times do |i|
  Game.create(
    description: Faker::ChuckNorris.fact,
    name: Faker::Book.unique.title,
    year: 2018,
    in_menu: true
  )
end

ActsAsTaggableOn::Tag.create(
  name: "sci-fi"
)

ActsAsTaggableOn::Tag.create(
  name: "fantasy"
)

ActsAsTaggableOn::Tag.create(
  name: "pixel art"
)

50.times do |i|
  offset = rand(Game.count)
  s = Screenshot.create(
    title: Faker::Book.unique.title,
    description: BetterLorem.p(1, true, false),
    game_id: Game.offset(offset).first.id,
    published: true,
    publication_date: Time.now,
    user_id: User.first.id,
    image: File.open(Rails.root + "app/assets/images/bg/bg_about.jpg")
  )
  if i.even?
    s.tag_list = "sci-fi, fantasy"
    s.save
  else
    s.tag_list = "pixel art"
    s.save
  end
end