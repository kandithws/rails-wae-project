Then("I should see the link {string}") do |string|
  find_link(string)
  # pending # Write code here that turns the phrase above into concrete actions
end

When("I click on the link {string}") do |string|
  find_link(string).click
  # pending # Write code here that turns the phrase above into concrete actions
end


Then("I should see {string}") do |string|
  expect(page).to have_content string
  # pending # Write code here that turns the phrase above into concrete actions
end