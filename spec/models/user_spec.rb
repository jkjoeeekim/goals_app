# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string           not null
#  session_token   :string           not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
    before(:each) do
        create(:user)
    end

    it { should validate_uniqueness_of(:username) }

    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }


    # describe 'uniqueness' do
    #     before(:each) do
    #         create(:user)
    #     end

    #     it { should validate_uniqueness_of(:username) }
    # end

    # describe 'presence' do
    #     before(:each) do
    #         create(:user)
    #     end

    #     it { should validate_presence_of(:password_digest) }
    #     it { should validate_presence_of(:session_token) }
    # end

    describe '.find_by_credentials' do
        user1 = User.create(username: "joey", password: "right_password")

        it "returns user given good credentials" do
            expect(User.find_by_credentials("joey", "right_password").username).to eq(user1.username)
        end

        it "returns nil given bad credentials" do
            expect(User.find_by_credentials("joey", "wrong_password")).to eq(nil)
        end
    end
end
