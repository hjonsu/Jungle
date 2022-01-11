require 'rails_helper'

RSpec.feature "Visitor adds an item to Cart", type: :feature, js: true do
   # SETUP
 before :each do
  @category = Category.create! name: 'Apparel'
  
  10.times do |n|
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end
end

  scenario "They see all the products" do
    
    # ACT
    visit root_path
    
    # CHECK FOR EMPTY CART
    expect(page).to have_content 'My Cart (0)'

    # ACT
    find_button('Add', match: :first).click

    # VALIDATE
    expect(page).to have_content 'My Cart (1)'

    # DEBUG
    save_screenshot
  end
end
