Given("i should see drop down to search category") do


find('a', :text => 'Search by Category')

end

When("i Click on it") do
  # find('#bs-example-navbar-collapse-1',:text => 'Search by Category').click
#   find_link('Search by Category').click
# page.find(:xpath, "//a[@href='/site/show']").click

find('a', :text => 'Search by Category').click
# find 'a#drop.dropdown-toggle'


end

Then("i see the categories to select") do

# #find_link('gadgets',href:"/site/show?name=gadgets").click
# visit '/site/show?name=gadgets'
#    save_and_open_page
#find(:select, from, options).find(:option, value, options).select_option
  #a=find('a', :text => 'Search by Category').all('li').collect(&:text)
  #  expect(a).to have_content ''




end

When("i click on the category {string}") do |string|
# @cat1 = FactoryGirl.build :dummy_category
# @cat2 = FactoryGirl.build :gadgets_category


end

Then("i see {string} posts") do |string|

end
