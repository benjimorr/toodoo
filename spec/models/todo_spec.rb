require 'rails_helper'

RSpec.describe Todo, type: :model do
    let(:user) { create(:user) }
    let(:todo) { create(:todo, user: user) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:items) }

    # Shoulda tests for title
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(3) }

    # Shoulda tests for category
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_length_of(:category).is_at_least(5) }

    # Shoulda test for user
    it { is_expected.to validate_presence_of(:user) }

    describe "attributes" do
        it "should have a title attribute" do
            expect(todo).to respond_to(:title)
        end

        it "should have a category attribute" do
            expect(todo).to respond_to(:category)
        end
    end
end
