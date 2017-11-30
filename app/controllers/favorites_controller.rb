class FavoritesController < ApplicationController
  before_action :logged_in_contributer

  def create
    @trick = Trick.find(params[:trick_id])
    current_contributor.like(@trick)
    respond_to do |format|
      format.html { redirect_to @trick }
      format.js 
    end
  end

  def destroy
    @trick = Favorite.find(params[:id]).trick
    current_contributor.unlike(@trick)
    respond_to do |format|
      format.html { redirect_to @trick }
      format.js 
    end
  end
end
