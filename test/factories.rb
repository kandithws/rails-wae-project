FactoryGirl.define do


  factory :user, class: User do
    email "joe@ait.asia"
    password "password"
    password_confirmation "password"
    username "joe"
    first_name "first"
    last_name "name"
    profession "Staff"
    cell_phone_no "12345"
    remember_created_at Time.now
    id '1'
  end

  factory :user2, class: User do
    email "jee@ait.asia"
    password "password"
    password_confirmation "password"
    username "jee"
    first_name "first"
    last_name "name"
    profession "Staff"
    cell_phone_no "12345"
    remember_created_at Time.now
  end

  factory :user3, class: User do
    email "joo@ait.asia"
    password "password"
    password_confirmation "password"
    username "joo"
    first_name "first"
    last_name "name"
    profession "Staff"
    cell_phone_no "12345"
    remember_created_at Time.now
  end

  factory :admin, class: User do
               username"admin"
               email "admin@ait.asia"
               password "adminadmin"
               password_confirmation "adminadmin"
               first_name 'ADMIN_Test'
               last_name 'ADMIN_Toast'
               profession "Staff"
               cell_phone_no "0891438432"
               admin true
               remember_created_at Time.now
  end

  factory :dummy_category, class: Category do
    name "dummy"
    desc "dummy cat to test"
  end

  factory :gadgets_category, class: Category do
    name "gadgets"
    desc "gadgets cat to test"

  end

  factory :nonbiditem1, class: Item do
    title "Sale Bose Sound Sport now!!!"
    type "NonBidItem"
    body "Blahh"
    category {Category.find_by_name("gadgets")}
    product_name "Bose Sound Sports"
    product_desc "bose bluetooth wireless headphones"
    product_price "5497.5841"
    # user_id 1
    sell_type true
  end

  factory :biditem1, class: Item do
    title "BLUEEEE"
    type "BidItem"
    body "Blahh"
    category {Category.find_by_name("dummy")}
    product_name "ket"
    product_desc "heeeha"
    product_price "5497.5841"
    sell_type true
    bid_end_time {DateTime.now + (10 * 60)}
    # user_id 1
    # association User,  factory: :user2
    # association  Category,factory: :gadgets_category
  end


  factory :bid_info, class: BidInfo do
    bid_price "2000.00"
  end

  factory :comment, class: Comment do
    body "bdfafdafadfafad"
  end

  factory :report, class: Report do
    reason "bdfafdafadfafad"
  end

end
