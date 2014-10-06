require "rails_helper"
require "spec_helper"

RSpec.describe HomeController, :type => :controller do
  render_views
  instance_variable_get("@completefinal")
  describe "GET #Contact" do
    it "should return 200 code" do
      get :contact
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("contact")
      expect(response.body).to match(/Contact Information/) #Correct Page
      expect(response.body).to match(/110 E Houston St/) #Correct Address
      expect(response.body).to match(/960-7222/) # Correct Phone Number
    end
  end

  describe "GET FAQ" do
    it "should return 200 code" do
      get :faq
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("faq")
    end
  end

  describe "GET Index" do
    it "should return 200 code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
      expect(response.body).to match(/Why Sell To Us/) #Proper Reasons Display
      expect(response.body).to have_selector('span', text: 'Select Your iPhone') #Panel Displays
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