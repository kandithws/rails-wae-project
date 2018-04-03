Given("I am user") do
  @user = FactoryGirl.create :user
end

Given("I'm signed in") do
  visit '/users/sign_in'
  fill_in 'Username', with: @user.username
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

When("I visit home page") do
  visit '/'

end

Then("I should see link for login") do
  find_link('Sign in')
end

When("I click the link for login") do

  find_link('Sign in').click

end

Then("I should see form to login") do
  expect(page).to have_selector('form')
end

When("I submit the credentials") do
  fill_in 'Username', with: @user.username
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

Then("I should visit main project page") do

  expect(page).to have_content "Today's Items"
end
