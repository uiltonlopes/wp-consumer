# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Create Namespace'

Namespace.create(namespace: '/wp-json/')
Namespace.create(namespace: '/wp-json/wp/v2/')
Namespace.create(namespace: '/?rest_route=/')
Namespace.create(namespace: '/?rest_route=/wp/v2/')
Namespace.create(namespace: '/?rest_route=/wp/v2/')

%w[site site2 blog].each do |namespace|
  Namespace.create(namespace: "/#{namespace}/wp-json/")
  Namespace.create(namespace: "/#{namespace}/wp-json/wp/v2/")
  Namespace.create(namespace: "/#{namespace}/?rest_route=/")
  Namespace.create(namespace: "/#{namespace}/?rest_route=/wp/v2/")
  Namespace.create(namespace: "/#{namespace}/?rest_route=/wp/v2/")
end

puts 'Success'
