require 'capybara/rspec'
require 'rails_helper'

describe "contact form", :type => :feature do

  it "Alert Success When Submitting" do
    visit '/home/contact'
    within("form") do
      fill_in 'email', :with => "text@example.com"
      fill_in 'subject', :with => "Test Subject"
      fill_in 'name', :with => "Test Person"
      fill_in 'message', :with => "Test Message"
    end
    click_button 'Submit'
    expect(page).to have_content "Message Sent. We'll get back to you ASAP!"
  end
end