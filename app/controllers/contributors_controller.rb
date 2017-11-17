class ContributorsController < ApplicationController
  def new
  end

  def show 
    @contributor = Contributor.find(params[:id])
  end
end
