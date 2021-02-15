# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  [
    {
      name: 'オフィスの近くの焼き芋を売ってる店がある',
      email: 'unko@sample.com',
      uid: '3'
    },
    {
      name: '焼き芋を配るフロントエンジニアがいるらしい',
      email: 'unkokkkokko@sample.com',
      uid: '5'
    }
  ]
)