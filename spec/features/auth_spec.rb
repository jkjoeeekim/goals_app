require 'spec_helper'
require 'rails_helper'

feature 'the signup process', type: :feature do

    before(:each) do
        visit(new_user_url)
    end

    scenario 'has a new user page' do
        expect(page).to have_content('Sign Up')
        expect(page).to have_content('Username:')
        expect(page).to have_content('Password:')
    end

    feature 'signing up a user', type: :feature do
        before(:each) do
            User.delete_all
            visit(new_user_url)
            # current_user = User.last
            # sign_up_user(current_user)
        end

        scenario 'shows username on the homepage after signup' do
            sign_up_user
            expect(page).to have_content("jkjoeyy")
        end

    end
end

feature 'logging in', type: :feature do
    before(:each) do
        visit(new_session_url)
        FactoryBot.build(:user)
        log_in_user(user)
    end

    scenario 'shows username on the homepage after login' do
        expect(page).to have_content(User.last.username)
    end

end

feature 'logging out', type: :feature do
    before(:each) do
        visit(session_url)
        subject(:user) do
            FactoryBot.build(:user)
        end
        log_out_user(User.last)
    end

    scenario 'begins with a logged out state' do
        expect(page).to have_current_path('/session/new')
    end

    scenario 'doesn\'t show username on the homepage after logout' do
        excpect(page).to_not have_content(User.last.username)
    end

end