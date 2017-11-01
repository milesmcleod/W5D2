# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(
  username: 'admin',
  password: 'password'
)
user.save

10.times do
  user = User.create(username: Faker::Name.name_with_middle, password: 'password')
end

10.times do
  user = User.create(username: Faker::Name.name, password: 'password')
end

[ 'hipsters',
  'politics',
  'dank memes',
  'fashion',
  'movies',
  'tv',
  'music',
  'rock collecting',
  'pokemon',
  'soccer',
  'boxing',
  'food',
  'beer',
  'NBA',
  'NFL',
  'geodesic domes',
  'tiny houses',
  'gardening',
  'capitalism',
  'marxism',
  'getting kind of crazy',
  'mexican foods',
  'the stupid president',
  'GSW',
  'runescape',
  'minecraft',
  'the spanish language',
  'bollywood',
  'calvin and hobbes',
  'MF Doom',
  'hip-hop',
  'cars',
  'boats',
  'trucks',
  'sauce',
  'spelling bees',
  'an estuary',
  'having terrible taste in shoes',
  'cool shoes',
  'dogs',
  'tequila'].map(&:downcase).sort.each do |sub_title|
  Sub.create(
    title: sub_title,
    description: Faker::TheFreshPrinceOfBelAir.quote,
    moderator_id: (1..5).to_a.sample
  )
end

120.times do
  Post.create(
    content: Faker::MostInterestingManInTheWorld.quote,
    title: Faker::Pokemon.name,
    author_id: rand(1..21),
    sub_ids: [rand(1..31)]
  )
end

400.times do
  Comment.create(
    content: Faker::HeyArnold.quote,
    author_id: rand(1..21),
    post_id: rand(1..120)
  )
end
