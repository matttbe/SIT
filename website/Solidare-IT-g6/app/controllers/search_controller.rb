class SearchController < ApplicationController


  # GET /search
  def match    
    
    # no filter (min 2 items in params)
    if (params.length <= 2)
      @services = Service.all # TODO: display all services?
    else
      @search = "/search?"
      if (! params[:q].nil?)
        @search += "q=" + params[:q] + "&"
      end
      if (! params[:type_q].nil?)
        @search += "type_q=" + params["type_q"]
      end
      
      if(! params[:offer_cbox].nil? and ! params[:demand_cbox].nil?) # Both checkboxes are checked
        @services = Service.all
      elsif(! params[:offer_cbox].nil?)
        @services = Service.where('is_demand = :is_demand', :is_demand => false)
      elsif(! params[:demand_cbox].nil?)
        @services = Service.where('is_demand = :is_demand', :is_demand => true)
      else
        @services = Service.all #TODO : What do we do if none of the checkboxes are checked ?
      end 

      #includes category infos
      @services=@services.includes(:category).references(:category)
      if (! params[:q].nil? and ! params[:q].empty? and !@services.nil?)
          @services = @services.where(:quick_match=>false).where('(services.title LIKE (:titles) or services.description LIKE (:titles) or categories.title LIKE (:titles) or categories.text LIKE (:titles))',
                   :titles => "%" + params[:q] + "%")
      end

      if (!params[:filter].nil?)
        @filter=params[:filter]
        if (@filter=="active")
          @services = @services.where('date_start < (:time) and date_end > (:time)',
                      :time=> Time.now)
        end

        if (@filter=="karma")
          @services = @services.joins(:user).where('users.karma>=0')
        end

        @search = @search + "&filter=" + @filter
      end

      if(!params[:category].nil?)
        @services = @services.where('category_id==:cato',:cato=>params[:category])
        @search = @search + "&category=" + params[:category]
      end

      if (! params[:q_order_end].nil?)
        @services = @services.order(date_end: :asc)
        @search = @search + "&q_order_end=on"
      end

      #toujours en dernier car on convertit services
      if (! params[:q_order_distance].nil?)
        #@services=@services.sort_by_distance_from(['50.70566' ,'4.74843'])
        @search = @search + "&q_order_distance=on"
      end

      @search = @search + "&commit=Search"      
      @services.reverse!
      @categories=@services.group_by &:category_id
    end
  end

end
