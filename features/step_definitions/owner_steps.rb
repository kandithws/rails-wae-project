Given("There few posts on the main page") do
  FactoryGirl.create :dummy_category
  FactoryGirl.create :gadgets_category
  @item1 = FactoryGirl.create :nonbiditem1
  @item2 = FactoryGirl.create :biditem1
  # @item1=Item.create(product_name: 'camera', product_price: '100B', user_id: @user.id)
  item_type = (@item1.type == 'BidItem') ? 'bidding' : 'non-bidding'
  tb = page.find('table#' + "#{item_type}")

  expect(tb).to have_content @item1.title
  expect(tb).to have_content @item1.product_name
  expect(tb).to have_content @user1.username

end

Given("i click on username of a post") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("i should see owner profile details") do
  pending # Write code here that turns the phrase above into concrete actions
end
