require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
before do
 @user = User.create!(
   first_name: "Cyn",
   last_name: "Cui",
   email: "cyn@cyn.com",
   password: "password",
   password_confirmation: "password"
 )
  end


  scenario "user is on products index page" do

  # ACT
  visit root_path
  find_link('Login').click
  fill_in 'email', with: 'cyn@cyn.com'
  fill_in 'password', with: 'password'
  click_on 'Submit'

  # VALIDATE
  expect(page).to have_link('Logout')

  # DEBUG
  save_screenshot
  end

end
