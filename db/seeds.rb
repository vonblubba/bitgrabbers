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
    name: Faker::Restaurant.name,
    year: 2018,
    order: i
  )
end

50.times do |i|
  Screenshot.create(
    title: "screenshot #{i}",
    description: BetterLorem.p(1, true, false),
    game_id: Game.first.id,
    published: true,
    publication_date: Time.now,
    user_id: User.first.id,
    image: File.open(Rails.root + "app/assets/images/bg/bg_about.jpg")
  )
end