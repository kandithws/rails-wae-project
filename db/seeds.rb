# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


admin = User.create( username:"admin",
            email: "admin@ait.asia",
            password: "adminadmin",
            password_confirmation: "adminadmin",
             first_name: 'ADMIN',
             last_name: 'ADMIN',
             cell_phone_no: "0891438432",
                     profession: 'staff',
            admin: true)


user1 = User.create( username:"joe",
             email: "joe@ait.ac.th",
             password: "secret123",
             password_confirmation: "secret123",
             first_name: 'Joe',
             last_name: 'Dailey',
                     profession: 'staff',
             cell_phone_no: "0899991457",
             admin: false)

user2 = User.create( username:"jee",
             email: "jee@ait.ac.th",
             password: "secret123",
             password_confirmation: "secret123",
             first_name: 'Jee',
             last_name: 'Daaaaaa',
                     profession: 'staff',
             cell_phone_no: "0899997777",
             admin: false)

cat_gadgets = Category.create( name: 'Gadgets', desc: 'All gadgets stuffs including blahh')
cat_dummy = Category.create( name: 'Dummy', desc: 'this is dummy gadgets')

NonBidItem.create(user: user1, category: cat_gadgets, title: 'Sale Bose Sound Sport now!!!', sell_type: true,
product_name: 'Bose Sound Sports', product_desc: 'bose bluetooth wireless headphones', product_price: 5497.5841)

NonBidItem.create(user: user1, category: cat_gadgets, title: 'Post2', sell_type: true,
                  product_name: 'afsddsaaf', product_desc: 'fffffff', product_price: 50)

NonBidItem.create(user: user2, category: cat_dummy, title: 'Post3: This one is very cheap', sell_type: true,
                  product_name: 'dummy_item', product_desc: 'fffffff', product_price: 50)