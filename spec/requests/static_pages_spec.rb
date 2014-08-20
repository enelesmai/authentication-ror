require 'rails_helper'
include ApplicationHelper

RSpec.describe "StaticPages", :type => :request do

  subject {page}
  
  describe "Home page" do
    before { visit root_path }

    it {should have_selector('h1',"Sample App")}
  	it {should have_title(full_title('Home'))}
  end 

  describe "Help page" do
    before { visit help_path }
  	
    it {should have_selector('h1',"Help")}
    it {should have_title(full_title('Help'))}
  end

  describe "About page" do
    before { visit about_path }

    it {should have_selector('h1',"About Us")}
    it {should have_title(full_title('About Us'))}
  end

  describe "Contact" do
    before { visit contact_path }
    
    it {should have_selector('h1',"Contact")}
    it {should have_title(full_title('Contact'))}
  end

end
