require 'rails_helper'

RSpec.describe ContributorsController, type: :controller do

  describe "GET #new" do
    specify 'route to new' do
      expect(:get => signup_path).to route_to(:controller => 'contributors', :action => 'new')
    end

    specify "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
