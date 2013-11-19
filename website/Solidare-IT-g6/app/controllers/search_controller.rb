class SearchController < ApplicationController


  # GET /search
  def match
    if(params[:q].nil?)
      @services = Service.all
    else
      @services=Service.where('title LIKE (:titles) or description LIKE (:titles)',
               :titles => "%"+params[:q]+"%").where('is_demand = :is_demand',
               :is_demand => params["type_q"]=="demand")
      if(!params[:q_order_end].nil?)
        @services=@services.order(date_end: :asc)
      end
    end
  end

end