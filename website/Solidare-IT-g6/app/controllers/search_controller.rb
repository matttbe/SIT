class SearchController < ApplicationController

  #GET /search/save
  def save
    @search = "/search?"
    @fav=FavoriteSearch.new
    @fav.user_id=current_user.id
    
    if (! params[:q].nil?)
      @fav.q=params[:q]
      @search += "q=" + params[:q] + "&"
    end
    @fav.is_demand=! params[:demand_cbox].nil?

    if (!params[:filter].nil?)
      @filter=params[:filter]
      @fav.is_active=@filter == "active"
      @fav.is_karma=@filter == "karma"
      @search = @search + "&filter=" + @filter
    end

    if(!params[:category].nil?)
      @fav.category_id= params[:category]
      @search = @search + "&category=" + params[:category]
    end

    if (! params[:q_order_end].nil?)
      @fav.is_order_end=true
      @search = @search + "&q_order_end=on"
    end

    if (! params[:q_order_distance].nil? && current_user.addresses.size > 0)
      @fav.is_order_distance=true
      @search = @search + "&q_order_distance=on"
    end

    @search = @search + "&commit=Search"
    @fav.save
    respond_to do |format|
        format.html {redirect_to @search, :notice => "You have saved this research "}
      end

  end
  
  def delete
	@fav = FavoriteSearch.find(params[:id])
	@fav.destroy
	respond_to do |format|
        format.html {redirect_to search_path, :notice => "You have deleted this research "}
      end
  end


  # GET /search
  def match
    @type=''
    if params[:type]=="organisation"
      @type="orga"
      search_organisation
    elsif params[:type]=="group"
      @type="group"
      search_group
    else
      @type="service"
      search_service
    end
    respond_to do |format|
        format.html
        format.js
    end
  end



  private
  def search_organisation
    @search = "/search?"
    @organisations=Organisation.all
    if (! params[:q].nil?)
      @search += "q=" + params[:q] + "&"
      @organisations=@organisations.where("name LIKE (:titles)", :titles => "%" + params[:q] + "%")
    end
  end

  def search_group
    @search = "/search?"
    @groups=Group.all
    if (! params[:q].nil?)
      @search += "q=" + params[:q] + "&"
      @groups=@groups.where("name LIKE (:titles) or description LIKE (:titles)", :titles => "%" + params[:q] + "%")
    end
  end
  
  def search_service
    # if (params.length <= 2) # no arg
    @search = "/search?"
    if (! params[:q].nil?)
      @search += "q=" + params[:q] + "&"
    end
    if (! params[:type_q].nil?)
      @search += "type_q=" + params["type_q"]
    end
    @services = Service.where(:quick_match => false).where('matching_service_id=0').paginate(:page => params[:page])
    if(! params[:offer_cbox].nil?)
      @services = Service.where('is_demand = :is_demand', :is_demand => false)
    elsif(! params[:demand_cbox].nil?)
      @services = Service.where('is_demand = :is_demand', :is_demand => true)
    end

    #includes category infos
    @services = @services.includes(:category).references(:category)
    if (! params[:q].nil? and ! params[:q].empty? and !@services.nil?)
        @services = @services.where(:quick_match=>false).where('(services.title LIKE (:titles) or services.description LIKE (:titles) or categories.title LIKE (:titles) or categories.text LIKE (:titles))',
                 :titles => "%" + params[:q] + "%")
    end

    if (!params[:filter].nil?)
      @filter=params[:filter]
      if (@filter == "active")
        @services = @services.where('date_start < (:time) and date_end > (:time)',
                    :time=> Time.now)
      end

      if (@filter == "karma")
        @services = @services.joins(:user).where('users.karma>=0')
      end

      #PAGINATE BEFORE ORDERING BECAUSE ORDERING CONVERT SERVICE TO ARRAY
      #if (defined? params[:page])
      #  @services = @services.paginate(:page => params[:page])
      #end

      #loooooooooooooool
      #if (! params[:q_order_end].nil?)
      #  @services = @services.order(date_end: :asc)
      #  @search = @search + "&q_order_end=on"
      #end
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
    if (! params[:q_order_distance].nil? && current_user.addresses.size > 0)

      #@services=@services.joins(:address).where("addresses.latitude is not 'nil'").order("ABS(addresses.longitude"+current_user.main_address.longitude.to_s+") and ABS(addresses.latitude-"+current_user.main_address.latitude.to_s+")")#, :lat=>current_user.main_address.latitude, :long=>current_user.main_address.longitude)
      @services = @services.joins(:address).sort_by{|r| r.distance(current_user.main_address.latitude,current_user.main_address.longitude)}.reverse
      #@services=@services.sort_by_distance_from(['50.70566' ,'4.74843'])
      @search = @search + "&q_order_distance=on"
    end

    @search = @search + "&commit=Search"
    @services.reverse!
    @categories = @services.group_by &:category_id
    
  end

end
