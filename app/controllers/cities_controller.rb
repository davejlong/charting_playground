class CitiesController < ApplicationController
  def index
    # @city = params[:city]
    @lat = params[:lat]
    @lng = params[:lng]
  end

  def show
    query = { per_page: 1000 }

    if !params['lat'].blank? && !params['lng'].blank?
      query.merge!({
        lat: params['lat'],
        lng: params['lng'],
        zoom: 10
      })
    end

    @issues = see_click_fix.issues(query)['issues']
  end

  private
  def see_click_fix
    @endpoint ||= SeeClickFix::SeeClickFix.new
  end
end
