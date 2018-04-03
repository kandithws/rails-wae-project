Given("i should see search bar") do
find 'div#search'
end

Given("i fill in with product_name") do
# FactoryGirl.create :gadgets_category
#   @item = FactoryGirl.create :nonbiditem1
# fill_in('search',:with => @item.product_name)
  fill_in 'search', with: 'Ket'
  # save_and_open_page

end

When("i click on search button") do
  page.find('input[name="commit"]').click

end

Then("i should see the posts of product_name") do

  # item_type = (@item.type == 'BidItem') ? 'bidding' : 'non-bidding'
  # tb = page.find('table#' + "#{item_type}")
  #
  # save_and_open_page
end
