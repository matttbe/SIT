class SearchController < ApplicationController


  # GET /search
  def match
    if(params[:q].nil?)
      @services = Service.all
    else
      @services=Service.where('title LIKE (:titles) or description LIKE (:titles)',
               :titles => "%"+params[:q]+"%")
    end
  end

end