class SearchController < ApplicationController


  # GET /search
  def match
    @services = Service.all
  end

end