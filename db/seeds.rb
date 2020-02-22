# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.all.destroy_all
Product.all.destroy_all
Review.all.destroy_all
Comment.all.destroy_all

User.create(username:"Sam",password:"123")
User.create(username:"Paul",password:"123")

Product.create(name:"Chocolate Chip",ingredients:['brown sugar','chocolate chip','wheat flour'])
Product.create(name:"Macadamia Nut",ingredients:['brown sugar','macadamia nut','white chocolate','wheat flour'])
Product.create(name:"Oatmeal Raisin",ingredients:['brown sugar','raisins','rolled oats','wheat flour'])

Review.create(rating:3,user:User.first,product:Product.second)
Review.create(rating:3,user:User.first,product:Product.first)
Review.create(rating:3,user:User.first,product:Product.third)
Review.create(rating:4,user:User.second,product:Product.third)
Review.create(rating:5,user:User.second,product:Product.first)

Comment.create(feedback:"absolutely yummy", user:User.first)
Comment.create(feedback:"macadamia nut cookies are the best", user:User.second)