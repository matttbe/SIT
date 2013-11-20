class SearchController < ApplicationController


  # GET /search
  def match

    if(params[:q].nil?)
      @services = Service.all
    else
      @search="/search?q="+params[:q]+"&type_q="+params["type_q"]
      @services=Service.where('title LIKE (:titles) or description LIKE (:titles)',
               :titles => "%"+params[:q]+"%").where('is_demand = :is_demand',
               :is_demand => params["type_q"]=="demand")
      if(!params[:filter].nil?)
        @filter=params[:filter]
        if @filter=="active"
          @services=@services.where('date_start < (:time) and date_end > (:time)',
               :time=> Time.now)
        end

        @search=@search+"&filter="+@filter
      end
      if(!params[:q_order_end].nil?)
        @services=@services.order(date_end: :asc)
        @search=@search+"&q_order_end=on"
      end
      @search=@search+"&commit=Search"
    end
  end

end