require 'spec_helper'
require 'rails_helper'

feature 'the signup process', type: :feature do

    before(:each) do
        visit(new_user_url)
        FactoryBot.build(:user)
        # subject(:user) do
        #     FactoryBot.build(:user)
        # end
    end

    # subject(:user) do
    #     FactoryBot.build(:user,
    #         username: "jkjoey",
    #         password: "good_password")
    # end

    scenario 'has a new user page' do
        expect(page).to have_content('Sign Up')
        expect(page).to have_content('Username:')
        expect(page).to have_content('Password:')
    end

    feature 'signing up a user', type: :feature do
        before(:each) do
            visit(new_user_url)
            subject(:user) do
                FactoryBot.build(:user)
            end
            sign_up_user(user)
        end

        scenario 'shows username on the homepage after signup' do
            expect(page).to have_content(user.username)
        end

    end
end

feature 'logging in', type: :feature do
    before(:each) do
        visit(new_session_url)
        subject(:user) do
            FactoryBot.build(:user)
        end
        log_in_user(user)
    end

    scenario 'shows username on the homepage after login' do
        expect(page).to have_content(user.username)
    end

end

feature 'logging out', type: :feature do
    before(:each) do
        visit(session_url)
        subject(:user) do
            FactoryBot.build(:user)
        end
        log_out_user(user)
    end

    scenario 'begins with a logged out state' do
        expect(page).to have_current_path('/session/new')
    end

    scenario 'doesn\'t show username on the homepage after logout' do
        excpect(page).to_not have_content(user.username)
    end

end