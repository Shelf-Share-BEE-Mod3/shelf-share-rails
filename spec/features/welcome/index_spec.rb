# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome Index Page Spec' do
  it 'I can visit the welcome page' do
    visit root_path
    expect(page).to have_content('Welcome to ShelfShare!')
  end
end
