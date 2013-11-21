class SearchController < ApplicationController


  # GET /search
  def match

    # no filter
    if (params.length <= 2) # The params hash will always contain the :controller and :action keys
      @services = Service.all # TODO: display all services?
    else
      @search = "/search?"
      if (! params[:q].nil?)
        @search += "/search?q=" + params[:q] + "&"
      end
      if (! params[:type_q].nil?)
        @search += "type_q=" + params["type_q"]
      end

      @services = Service.where('is_demand = :is_demand',
                  :is_demand => params["type_q"] == "demand")

      if (! params[:q].nil? and ! params[:q].empty?)
        @services = @services.where('title LIKE (:titles) or description LIKE (:titles)',
                   :titles => "%" + params[:q] + "%")
      end

      if (!params[:filter].nil?)
        @filter=params[:filter]
        if (@filter=="active")
          @services = @services.where('date_start < (:time) and date_end > (:time)',
                      :time=> Time.now)
        end

        @search = @search + "&filter=" + @filter
      end

      if (! params[:q_order_end].nil?)
        @services = @services.order(date_end: :asc)
        @search = @search + "&q_order_end=on"
      end

      @search = @search + "&commit=Search"
    end
  end

end
