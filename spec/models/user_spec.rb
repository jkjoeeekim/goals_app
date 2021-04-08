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

    describe 'uniqueness' do
        before(:each) do
            create(:user)
        end

        it { should validate_uniqueness_of(:username) }
    end

    describe 'presence' do
        before(:each) do
            create(:user)
        end

        it { should validate_presence_of(:password_digest) }
        it { should validate_presence_of(:session_token) }
    end
end
