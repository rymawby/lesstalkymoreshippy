require 'spec_helper'
require 'cancan/matchers'


describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "changeme",
      :password_confirmation => "changeme"
    }
  end

  it { should have_many(:projects) }
  it { should have_many(:targets).through(:projects) }

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "Creator" do

    before(:each) do 
      @user = FactoryGirl.create(:user)
      @user.add_role :creator

      @project = FactoryGirl.create(:project)
    end

    it "should be able to create a project" do
      ability = Ability.new(@user)

      @project.update_attribute(:creator_id, @user.id)

      ability.should be_able_to(:create, @project)
    end


    it "should be able to create a target" do
      ability = Ability.new(@user)

      @project.update_attribute(:creator_id, @user.id)
      @target = FactoryGirl.create(:target)
      @target.update_attribute(:project_id, @project.id)

      ability.should be_able_to(:create, @target)
    end

    it "should not be able to validate a target" do
      @project.update_attribute(:validator_id, @user.id)
      @target = FactoryGirl.create(:target)
      @target.update_attribute(:project_id, @project.id)

      @target.validate(@user)

      @target.complete.should be_false
    end

  end

  describe "Validator" do

    before(:each) do 
      @user = FactoryGirl.create(:user)
      @user.add_role :validator

      @project = FactoryGirl.create(:project)
    end

    it "should be able to validate a target" do
      ability = Ability.new(@user)

      @project.update_attribute(:validator_id, @user.id)
      @target = FactoryGirl.create(:target)
      @target.update_attribute(:project_id, @project.id)

      ability.should be_able_to(:validate, @target)

      @target.validate(@user)

      @target.complete.should be_true
    end

    it "should not be able to create a project" do
      ability = Ability.new(@user)

      @project.update_attribute(:validator_id, @user.id)

      ability.should_not be_able_to(:create, @project)
    end

    it "should not be able to create a target" do
      ability = Ability.new(@user)

      @project.update_attribute(:validator_id, @user.id)
      @target = FactoryGirl.create(:target)
      @target.update_attribute(:project_id, @project.id)

      ability.should_not be_able_to(:create, @target)
    end

  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

end
