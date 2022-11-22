require 'rails_helper'

RSpec.describe User, type: :model do
  
before do
  @user1 = User.new(:name => 'Matt', :email => 'mw@gmail.com', :password => '12345', :password_confirmation => '12345')

  @user2 = User.new(:password => '12345', :password_confirmation => '12345')


  @user3 = User.new(:password => '12345', :password_confirmation => '54321')

  @user4 = User.new(:name => 'John', :email => 'mw@gmail.com', :password => '54321', :password_confirmation => '54321')
  
  @user1.save
  @user2.save
  @user3.save
  @user4.save
end

describe 'Validations' do
  it "should have all fields" do
    expect(@user1.name).to be_present
    expect(@user1.email).to be_present
    expect(@user1.password).to be_present
    expect(@user1.password_confirmation).to be_present
  end

  it "should error if email already exists" do
    expect(@user4).to_not be_valid
    expect(@user4.errors.full_messages).to include("Email has already been taken")
  end

  it "should have password and password_confirmation fields" do
    expect(@user2.password).to be_present
    expect(@user2.password_confirmation).to be_present
  end

  it "should have matching password and password_confirmation fields" do
  expect(@user2.password).to eql(@user2.password_confirmation)
  end

  it "should NOT have matching password and password_confirmation fields" do
    expect(@user3.password).not_to eql(@user3.password_confirmation)
  end

  it "validates email for case sensitivity" do
    new_email = 'MW@gmail.com'
    expect(new_email.downcase).to eql(@user1.email)
  end

  it "should have a minimum password length of 4 characters" do
    new_password = '1234'
    expect(new_password.length).to be >= 4
  end

end


describe '.authenticate_with_credentials' do

  it "should return user info if user is valid" do
    expect(@user1.authenticate_self('mw@gmail.com', '12345')).to be_instance_of(User)
  end

  it "should return nil if the user info is invalid" do
    expect(@user1.authenticate_self('fake@fake.com', 'fake')).to be_nil
  end

  it "should authenticate with extra white spaces" do
    expect(@user1.authenticate_self('  mw@gmail.com  ', '12345')).to be_instance_of(User)
  end

  it "should authenticate with wrong character case" do
    expect(@user1.authenticate_self('mW@gMaIl.CoM', '12345')).to be_instance_of(User)
  end



end


end