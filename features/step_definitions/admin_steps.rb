Given("Preparation") do
  @users = {}
end

Given("I am an admin") do
  @users = {}
  @users[:admin] = FactoryGirl.create :admin
end

Given("There are some users in the system") do
  @users[:user1] = FactoryGirl.create :user
  @users[:user2] = FactoryGirl.create :user2
end

Given("I'm signed in as admin") do
  visit '/users/sign_in'
  fill_in 'Username', with: @users[:admin].username
  fill_in 'Password', with: @users[:admin].password
  click_button 'Log in'
end


When("I visit the admin dashboard") do
  visit '/admin'


end

When("I click on users tab on the navigation bar") do
  all('a', :class => 'pjax', :text => 'Users')[1].click
  # https://stackoverflow.com/questions/43396872/capybara-click-element-by-class-name
  # https://stackoverflow.com/questions/13878946/how-to-find-an-element-by-matching-exact-text-of-the-element-in-capybara
end

Then("I should see list of recently registered users") do
  expect(page).to have_content 'List of Users'
end

When("Another user has just create an account") do
  @users[:user3] = FactoryGirl.create :user3
end

When("I refresh the page and click to sort on {string}") do |string|
  click_button 'Refresh'
  # https://stackoverflow.com/questions/34092985/find-elements-by-data-attributes
  page.find("a[data-field-label=\"#{string}\"]").click
end

Then("I should see that new user added to the list on the top") do
  expect(page).to have_content @users[:user3].email
  # https://stackoverflow.com/questions/39479485/finding-a-specific-row-in-a-table-using-capybara
  # https://stackoverflow.com/questions/25419885/how-to-get-a-particular-table-cell-text-with-row-column-values-in-capybara-witho
  # Note: "find" cannot get multiple items, use "all" instead
  first_row = page.find("tbody").all("tr")[0] # getting the first row
  expect(first_row).to have_content @users[:user3].email
end

Given("I want to ban {string}") do |string|
  @users[string.to_sym] = FactoryGirl.create string.to_sym
end


When("I click on that {string}'s {string} icon") do |string, string2|
  # Search row and click icon utils for admin in Model dashboard
  row = nil
  page.find("tbody").all("tr").each do |tr|
    if tr.should have_content(@users[string.to_sym].email)
      row = tr
      break
    end
  end
  row.find("ul").find_link(string2).click
end


Then("I should see a banned tick box") do
  #https://stackoverflow.com/questions/12653506/rspec-capybara-check-existence-of-tag-with-its-css-class
  page.should have_css('div#user_banned_field')
end

When("I click on the banned tick box and saved") do
  # https://stackoverflow.com/questions/8297624/how-to-check-a-checkbox-in-capybara
  page.find(:css, 'div#user_banned_field').find("input[type='checkbox']").set(true)
  click_button 'Save'
end

When("I logged out") do
  click_link 'Log out'
  # pending # Write code here that turns the phrase above into concrete actions
end

When("I login as {string}") do |string|
  # pending # Write code here that turns the phrase above into concrete actions
  click_link 'Sign in'
  fill_in 'Username', with: @users[string.to_sym].username
  fill_in 'Password', with: @users[string.to_sym].password
  click_button 'Log in'
end

Given("I sign out") do
  click_link 'Sign out'
  # pending # Write code here that turns the phrase above into concrete actions
end


Then("I should see History record of this user") do
  expect(page).to have_content('History for User')
end






