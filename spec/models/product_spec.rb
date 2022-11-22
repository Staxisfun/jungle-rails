require 'rails_helper'
require 'products_controller'

RSpec.describe Product, type: :model do

before do
  @productAll = Product.new(:name => 'Matt', :price_cents => 30, :quantity => 5, :category_id => 2)

  @productName = Product.new(:price_cents => 30, :quantity => 5, :category_id => 2)

  @productPrice = Product.new(:name => 'Matt', :quantity => 5, :category_id => 2)

  @productQuantity = Product.new(:name => 'Matt', :price_cents => 30, :category_id => 2)

  @productCategory = Product.new(:name => 'Matt', :price_cents => 30, :quantity => 5)

  @productAll.save
  @productName.save
  @productPrice.save
  @productQuantity.save
  @productCategory.save

end


describe 'Validations' do
  it "should have all fields" do
    expect(@productAll.name).to be_present
    expect(@productAll.price_cents).to be_present
    expect(@productAll.quantity).to be_present
    expect(@productAll.category_id).to be_present
end


  it "should have all fields but name" do
    expect(@productName.name).to be_nil
    expect(@productName.price_cents).to be_present
    expect(@productName.quantity).to be_present
    expect(@productName.category_id).to be_present

    expect(@productName.errors.full_messages).to include("Name can't be blank")
end


  it "should have all fields but price" do
    expect(@productPrice.name).to be_present
    expect(@productPrice.price_cents).to be_nil
    expect(@productPrice.quantity).to be_present
    expect(@productPrice.category_id).to be_present

    expect(@productPrice.errors.full_messages).to include("Price can't be blank")
end


  it "should have all fields but quantity" do
    expect(@productQuantity.name).to be_present
    expect(@productQuantity.price_cents).to be_present
    expect(@productQuantity.quantity).to be_nil
    expect(@productQuantity.category_id).to be_present

    expect(@productQuantity.errors.full_messages).to include("Quantity can't be blank")
end


it "should have all fields but category_id" do
  expect(@productCategory.name).to be_present
  expect(@productCategory.price_cents).to be_present
  expect(@productCategory.quantity).to be_present
  expect(@productCategory.category_id).to be_nil

  expect(@productCategory.errors.full_messages).to include("Category can't be blank")
end
end
end