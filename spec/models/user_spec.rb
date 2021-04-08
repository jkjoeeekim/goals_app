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
    subject(:user) do
        FactoryBot.build(:user,
            username: "jkjoey",
            password: "good_password")
    end

    # SHOULDA-MATCHERS SPECS
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }


    it "creates a password_digest when a password is given" do
        expect(:password_digest).to_not be_nil
    end

    it "creates a session_token before validation" do
        user.valid?
        expect(user.session_token).to_not be_nil
    end


    describe '.find_by_credentials' do
        before { user.save! }
        it "returns user given good credentials" do
            expect(User.find_by_credentials("jkjoey", "good_password").username).to eq(user.username)
        end

        it "returns nil given bad credentials" do
            expect(User.find_by_credentials("joey", "wrong_password")).to eq(nil)
        end
    end

    describe "#generate_session_token" do
        it "creates a unique session_token every time" do
            token1 = user.generate_session_token
            token2 = user.generate_session_token
            expect(token1).to_not eq(token2)
        end

        it "creates a session_token with a length of 32" do
            expect(user.session_token.length).to eq(32)
        end
    end

    describe '#reset_session_token' do
        it "assigns a new session_token to the user" do
            old_session_token = user.session_token
            expect(user.reset_session_token).to_not eq(old_session_token)
        end

        it "returns the new session_token" do
            expect(user.reset_session_token).to eq(user.session_token)
        end
    end
end
