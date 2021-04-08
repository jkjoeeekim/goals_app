# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do

    describe 'uniqueness' do
        before(:each) do
            create(:user)
        end

        it { should validate_uniqueness_of(:username) }
    end

end
