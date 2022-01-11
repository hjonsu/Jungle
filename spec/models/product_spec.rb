require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid with valid attributes" do
      @product = Product.new
      @category = Category.new
      @category.name = 'TestCategory'
      @product.name = 'TestProduct'
      @product.price_cents = 22222
      @product.quantity = 2
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it "should not pass without a name" do
      @product = Product.new
      @category = Category.new
      @category.name = 'TestCategory'
      @product.name = nil
      @product.price_cents = 22222
      @product.quantity = 2
      @product.category = @category
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to match(["Name can't be blank"])
    end

    it "should not pass without a price" do
      @product = Product.new
      @category = Category.new
      @category.name = 'TestCategory'
      @product.name = 'TestProduct'
      @product.price_cents = nil
      @product.quantity = 2
      @product.category = @category
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to match(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it "should not pass without a quantity" do
      @product = Product.new
      @category = Category.new
      @category.name = 'TestCategory'
      @product.name = 'TestProduct'
      @product.price_cents = 22222
      @product.quantity = nil
      @product.category = @category
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to match(["Quantity can't be blank"])
    end

    it "should not pass without a category" do
      @product = Product.new
      @category = Category.new
      @category.name = 'TestCategory'
      @product.name = 'TestProduct'
      @product.price_cents = 22222
      @product.quantity = 2
      @product.category = nil
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to match(["Category can't be blank"])
    end
  end
end
