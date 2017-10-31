require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { create(:user) }

    # Shoulda tests for name
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(5) }

    # Shoulda tests for email
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_least(5) }
    it { is_expected.to allow_value("user@toodoo.com").for(:email) }

    # Shoulda tests for password
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to have_secure_password }

    describe "attributes" do
        it "should have a name attribute" do
            expect(user).to respond_to(:name)
        end

        it "should have an email attribute" do
            expect(user).to respond_to(:email)
        end
    end

    describe "invalid user" do
        let (:user_with_invalid_name) { build(:user, name: "") }
        let (:user_with_invalid_email) { build(:user, email: "") }
        let (:user_with_invalid_pw) { build(:user, password: "") }

        it "should be an invalid user due to blank name" do
            expect(user_with_invalid_name).to_not be_valid
        end

        it "should be an invalid user due to blank email" do
            expect(user_with_invalid_email).to_not be_valid
        end

        it "should be an invalid user due to blank password" do
            expect(user_with_invalid_pw).to_not be_valid
        end
    end
end
