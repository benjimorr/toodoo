require 'rails_helper'

RSpec.describe Item, type: :model do
    let(:user) { create(:user) }
    let(:todo) { create(:todo) }
    let(:item) { create(:item) }

    it { is_expected.to belong_to(:todo) }

    # Shoulda tests for name
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(5) }

    # Shoulda test for todo list
    it { is_expected.to validate_presence_of(:todo) }

    describe "attributes" do
        it "should have a name attribute" do
            expect(item).to respond_to(:name)
        end

        it "should have a complete attribute" do
            expect(item).to respond_to(:complete)
        end
    end
end
