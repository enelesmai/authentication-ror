require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
   def setup
      @user  = User.new(name: "Example User", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar")
   end

   ##########################################################
   #verifying existence of the attributes
   #---------------------------------------------------------
   test "should have a name attribute" do
   	assert_respond_to(@user, :name) # a way
   end
   test "should have a email attribute" do 
   	assert(@user.respond_to?(:email)) # another way
   end
   test "should have password attribute" do
      assert(@user.respond_to?(:password))
   end
   test "should have password confirmation attribute" do
      assert(@user.respond_to?(:password_confirmation))
   end
   test "should have authenticate method" do
      assert_respond_to(@user, :authenticate)
   end
   ##########################################################


   ##########################################################
   #not empty fields
   #---------------------------------------------------------
   test "should not save user without name --email" do
      a_user = User.new
      assert !a_user.save, "Saved the user without a name"
   end
   test "password is empty" do 
      a_user = users(:one)
      assert !a_user.save, "Saved the user without password"
   end
   ##########################################################


   ##########################################################
   #validations of data
   #---------------------------------------------------------
   test "name should not be too long" do
    		user = User.create(:name => "a"*51, :email => "email@correo.com")
   		assert_equal(false, user.save, "name.lenght should not be more than 50")
   end
   test "reject duplicated email" do
      prng = Random.new
      user = User.new(:name => "Example", :email => "user#{prng.rand(9999)}@example.com")
      user.save
      new_user = user.dup
      new_user.email= user.email.upcase
      assert !new_user.save, "Saved duplicated user"
   end
   test "password should not be too short" do
      @user.password = @user.password_confirmation = "a" * 5
      assert !@user.save, "password should not be too short"
   end
   test "password_confirmation doesn't match" do
      user = User.new(:name => "Example", :email => "user2@example.com", :password => "foobar", :password_confirmation => "mismatch")
      assert !user.save, "Saved when password_confirmation doesn't match"
   end
   test "email address with mixed case" do
      mixed_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_email
      @user.save
      assert_equal(@user.reload.email, mixed_email.downcase)
   end
   test "invalid email format" do
      invalid_format = "foo@bar..com"
      @user.email = invalid_format
      assert !@user.save, "user saved with invalid email format"
   end
   ##########################################################

   ##########################################################
   #authenticate test
   #---------------------------------------------------------
   test "let valid password" do
      @user.save
      the_user = User.find_by_email(@user.email)
      assert the_user.authenticate(@user.password)
   end
   test "let invalid password" do
      @user.save
      the_user = User.find_by_email(@user.email)
      assert !the_user.authenticate("invalid")
   end
   ##########################################################

end
