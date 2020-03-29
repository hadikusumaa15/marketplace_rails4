require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  it { should validate_presence_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  # Devise overrides #email= to ensure that all emails are stored as lowercase in the database.
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
end

# brspec spec/models/user_spec.rb