class CitiesController < ApplicationController
  def index
    @city = params[:city]
  end

  def show
    render json: see_click_fix.issues(address: params[:city], per_page: 100)
  end

  private
  def see_click_fix
    @endpoint ||= SeeClickFix::SeeClickFix.new
  end
end
