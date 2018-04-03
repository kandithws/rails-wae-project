Given("There are some category in the system") do
  # pending # Write code here that turns the phrase above into concrete actions
  FactoryGirl.create :dummy_category
  FactoryGirl.create :gadgets_category
end

Given("I have a bid item") do
  @item = FactoryGirl.build :biditem1
end

Given("I have a non bid item") do
  # pending # Write code here that turns the phrase above into concrete actions
  @item = FactoryGirl.build :nonbiditem1
end


Then("I should see the form for the item") do
  expect(page).to have_selector('form')
end

When("I filled up the form to post the item and submit") do
  fill_in 'Title', with: @item.title
  fill_in 'Body', with: @item.body
  fill_in 'Product name', with: @item.product_name
  fill_in 'Product description', with: @item.product_desc
  fill_in 'Product price', with: @item.product_price
  page.find('#sell_type').find(:option, (@item.sell_type ? "Sell": "Buy") ).select_option
  # save_and_open_page
  page.find(:select, name: 'item[type]').find(:option, @item.type ).select_option

  page.find(:select, name: 'item[category_id]').find(:option, @item.category.name ).select_option
  fill_in 'item_bid_end_time',
          with: @item.bid_end_time.localtime.strftime('%m/%d/%Y %I:%M %p') unless @item.bid_end_time.nil?

  page.find('input[name="commit"]').click
end

Then("I should see my item on the same list type") do
  item_type = (@item.type == 'BidItem') ? 'bidding' : 'non-bidding'
  tb = page.find('#' + "#{item_type}")

  expect(tb).to have_content @item.title
  expect(tb).to have_content @item.product_name
  expect(tb).to have_content @user.username

  # expect(tb).to have_content @item.user.username
  # Write code here that turns the phrase above into concrete actions
end


Given("There is an Item") do
  @item = FactoryGirl.build :nonbiditem1
  @item.user = FactoryGirl.create :user3
  @item.save
  # pending # Write code here that turns the phrase above into concrete actions
end

Given("I want to comment on it") do
  @comment = FactoryGirl.build :comment
  # pending # Write code here that turns the phrase above into concrete actions
end

When("I click on the Item title") do
  visit '/'
  click_link @item.title
  # pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see the comment form") do
  expect(page).to have_selector('form#new_comment')
  # pending # Write code here that turns the phrase above into concrete actions
end

When("I type my comment and submit") do
  fill_in 'comment_body', with: @comment.body
  page.find('input[value="Create Comment"]').click
  # pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see my comment in the item page") do
  expect(page).to have_content @comment.body
  # pending # Write code here that turns the phrase above into concrete actions
end

Given("I want to report") do
  @report = FactoryGirl.build :report
  # pending # Write code here that turns the phrase above into concrete actions
end


Then("I should see the form for the report") do
  expect(page).to have_selector('form#new_report')
  # pending # Write code here that turns the phrase above into concrete actions
end

When("I fill the report and submit") do
  fill_in 'report_reason', with: @report.reason
  page.find('input[value="Create Report"]').click
  # pending # Write code here that turns the phrase above into concrete actions
end

Then("I should not see {string}") do |string|
  expect(page).not_to have_content(string)
  # pending # Write code here that turns the phrase above into concrete actions
end

