Given("i should see {string} button") do |string|
    find_link(string)
end


When("i click on {string} button") do |string|
  find_link(string).click

end


Then("i should see my profile details") do
    expect(page).to have_content @user.username
    expect(page).to have_content @user.first_name
    expect(page).to have_content @user.last_name
    expect(page).to have_content @user.cell_phone_no
    expect(page).to have_content @user.profession
    # save_and_open_page
end
Then("i click on edit profile") do
  find_link('Edit your profile').click

end

Then("i see fields filled with my details") do
  expect(find_field('Username').value).to eq @user.username
    expect(find_field('Email').value).to eq @user.email
  expect(find_field('Cell phone no').value).to eq @user.cell_phone_no
    expect(find_field('Profession').value).to eq @user.profession


end
Then("i update my cell_phone_no") do
 fill_in('Cell phone no', :with => '12345678910')
end

When("i click on update user") do
  click_button 'Update User'
end

Then("i should see my updated profile") do
  expect(page).to have_content @user.cell_phone_no

end
