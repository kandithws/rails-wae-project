Given("I a new user with ait email") do
  @user = FactoryGirl.build :user
  # pending # Write code here that turns the phrase above into concrete actions
end



Then("I should see the form to validate email") do
  expect(page).to have_selector('form')
  # pending # Write code here that turns the phrase above into concrete actions
end

When("I fill the form with my e-mail and submit") do
  fill_in 'email', with: @user.email
  click_button 'Validate Email'
  # pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see the form to fill my additional information") do
  expect(page).to have_selector('form')
  # pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see my email already filled") do
  # https://stackoverflow.com/questions/10503802/how-can-i-check-that-a-form-field-is-prefilled-correctly-using-capybara
  expect(find_field('Email').value).to eq @user.email
  # pending # Write code here that turns the phrase above into concrete actions
end


When("I fill the additional information and submit") do
  fill_in 'Username', with: @user.username
  fill_in 'Password', with: @user.password
  fill_in 'Password confirmation', with: @user.password_confirmation
  fill_in 'First name', with: @user.first_name
  fill_in 'Last name', with: @user.last_name
  fill_in 'Cell phone no', with: @user.cell_phone_no
  page.find('#user_profession').find(:option, (@user.profession) ).select_option
  # save_and_open_page
  # fill_in 'Profession', with: @user.profession
  # pending # Write code here that turns the phrase above into concrete actions
  click_button 'Sign up'
end




