require "rails_helper"
require "spec_helper"

RSpec.describe HomeController, :type => :controller do
  describe "GET #Contact" do
    it "should return 200 code" do
      get :contact
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET FAQ" do
    it "should return 200 code" do
      get :faq
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET Index" do
    it "should return 200 code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET Notifications" do
    it "should return 200 code" do
      get :notifications
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

end