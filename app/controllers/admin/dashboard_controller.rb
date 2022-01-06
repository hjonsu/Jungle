require 'dotenv/load'
class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV["Admin_User"], :password => ENV["Admin_PW"]
  def show
    @product_quantity = Product.count
    @category_quantity = Category.count
  end
end
