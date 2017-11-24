require 'rails_helper'

RSpec.describe ContributorsController, type: :controller do

  describe "http request" do
    specify 'route to new' do
      expect(:get => signup_path).to route_to(:controller => 'contributors', :action => 'new')
    end

    specify "GET new returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    specify "GET show returns http should be success" do
      @contributor = FactoryGirl.create(:contributor)
      get :show, params: {id: @contributor.id}
      expect(response).to have_http_status(:success)
    end

  end

end
