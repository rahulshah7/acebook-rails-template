# frozen_string_literal: true

require 'rails_helper'
require_relative './login_helper'

RSpec.feature 'Post timeline feature', type: :feature do
  before(:each) do
    log_in_user
    visit '/posts'
  end

  scenario 'Can submit posts and view them' do
    expect(page).to have_content('Hello, world!')
    expect(find_all('.card-subtitle').first.text).to match(/\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s\w{3}/)
  end

  scenario 'Can submit multiple posts and view them in reverse chronological order' do
    click_link 'New post'
    fill_in 'Message', with: 'Hello, universe!'
    click_button 'Submit'
    expect(find('.container').text).to match(/Hello, universe!.*Hello, world!/)
  end

  scenario 'User can delete posts' do
    expect(find('.container').text).to match(/Hello, world!/)
    find_all('.button-delete').first.click
    expect(find('.container').text).not_to match(/Hello, world!/)
  end
end