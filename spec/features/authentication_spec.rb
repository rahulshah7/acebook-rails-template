# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  scenario 'Can sign up' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'testemail@domain.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'Can sign in' do
    User.create(email: 'newuser@gmail.com', password: 'Pass123-')
    visit '/users/sign_in'
    fill_in 'Email', with: 'newuser@gmail.com'
    fill_in 'Password', with: 'Pass123-'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'Can log out' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'testemail@domain.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    click_button 'Sign up'
    click_link 'Log Out'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'Can use login button' do
    visit '/'
    click_link 'Login'
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end
end
