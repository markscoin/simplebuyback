require 'spec_helper'
require 'rails_helper'

describe "Notifier Mailer" do
  describe "Welcome Email" do
    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @user = FactoryGirl.create(:user)
      Notifier.welcome_email(@user).deliver
    end
    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
    specify { expect ActionMailer::Base.deliveries.count eq(1)} #Email Sent
    specify { expect ActionMailer::Base.deliveries.first.subject eq("Welcome to SimpleBuyBack")} #Subject Line
    specify { expect ActionMailer::Base.deliveries.first.to eq(["#{@user.email}"])} # TO
    specify { expect ActionMailer::Base.deliveries.first.from eq(["support@simplebuyback.com"])} #FROM
  end

  describe "Contact Email" do
    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      name = "Test Name"
      email = "example@example.com"
      subject = "Test Subject"
      message = "Test Message"
      Notifier.contact_email(name,email,subject,message).deliver
      @mail =  Notifier.contact_email(name,email,subject,message)
    end
    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    specify { expect ActionMailer::Base.deliveries.count eq(1)} # Email Sent
    specify { expect ActionMailer::Base.deliveries.first.subject eq("Support Request")} # Subject Line
    specify { expect ActionMailer::Base.deliveries.first.to eq(["support@simplebuyback.com"])} #TO
    specify { expect ActionMailer::Base.deliveries.first.from eq(["#{@email}"])} # FROM
    specify { expect(ActionMailer::Base.deliveries.first.body.raw_source).to include("Test Name")}
    specify { expect(ActionMailer::Base.deliveries.first.body.raw_source).to include("Test Message")}
  end
end