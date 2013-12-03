class ServicesController < ApplicationController
  before_action :set_service, only: [:edit, :update, :destroy, :accept_service, :follow, :unfollow]
  before_action :set_good_service, only: [:create_transaction, :new_transaction]

  #GET /user/following_services
  def following_services
    if user_signed_in?
      @following = Follower.where("user_id = :user_id", :user_id => current_user.id)      
    end
  end

  # GET /user/services
  def my_services
    if user_signed_in?
      @services = current_user.own_services.order(:is_demand)
    else
      dont_see
    end
  end

  # GET /services/:id/accept
  def accept_service
    if @service.matching_service.nil?
      notify_owner(@service)
      create_quick_service
      @service.matching_service=@serviceQ
      respond_to do |format|
        format.html { redirect_to my_services_path, notice: 'you have accepted a service' }
      end
    else
      #TODO
    end
  end
  
  # GET /services
  # GET /services.json
  def index
    respond_to do |format|
        format.html { redirect_to match_path }
      end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    protect_param_integer
    if @can
    @service = Service.find(params[:id])
   #NETTOYER ca pour faire une seule fois la requete followers
    @followers_list = Follower.where("service_id = :service_id", :service_id => @service.id)  
    end
  end

  # GET /services/new
  def new
    if user_signed_in?
      @service = Service.new
    else
      dont_see
    end
  end

  # GET /services/1/edit
  def edit
    if !(@service.creator_id==current_user.id)
      dont_see
    end    
  end

  # POST /services
  # POST /services.json
  def create
      @service = Service.new(service_params)
      @service.creator_id=current_user.id

      respond_to do |format|
        if @service.save
          format.html { redirect_to @service, notice: 'Service was successfully created.' }
          format.json { render action: 'show', status: :created, location: @service }
        else
          show_error(format,'new',@service)
        end
      end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    if !(@service.creator_id==current_user.id)
      dont_see
    else
      notify(@service)
      respond_to do |format|
        if @service.update(service_params)
          format.html { redirect_to @service, notice: 'Service was successfully updated.' }
          format.json { head :no_content }
        else
          show_error(format,'edit',@service)
        end
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    if !(@service.creator_id==current_user.id)
      dont_see
    else
      @service.destroy
      respond_to do |format|
        format.html { redirect_to services_url }
        format.json { head :no_content }
      end
    end
  end

  #Transaction

  #GET /transaction/:id
  def new_transaction
    @transaction=Transaction.new
  end
  
  #PUT /transaction/:id
  def create_transaction
    @transaction=Transaction.new(transaction_params)
    @transaction.user_id=@service.creator_id
    @transaction.service_id=@service.id
    @user=User.find(@transaction.user_id)
    @user.karma=@user.karma+@transaction.feedback_evaluation
    #TODO update karma
    respond_to do |format|
       if @transaction.save && @user.save
         format.html { redirect_to my_services_path, notice: 'thanks for your feedback !' }
         format.json { head :no_content }
       else
         show_error(format,'my_services',@transaction)
       end
     end
  end
  
  def follow   
    if user_signed_in?
      @followers = Follower.where("service_id = :service_id AND user_id = :user_id", :service_id => @service.id, :user_id => current_user.id)
      if @followers.size == 0
        @follower = Follower.new
        @follower.service = @service
        @follower.user = current_user
        respond_to do |format|
          if @follower.save
            format.html{redirect_to request.referer, notice: 'You follow the service'}
          else
            show_error(format, 'show', @follower)
          end
        end
     else
       show_error("You already follow this service")
     end
    else
      dont_see
    end
 end
    
  def unfollow
    @follower = Follower.find(params[:follower_id])
    respond_to do |format|
      if @follower.destroy
        format.html{redirect_to request.referer, notice: 'Service unfollow'}
      else
        show_error(format, 'show', @follower)
      end
    end
  end


# ----------- PRIVATE -------------------------------

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_good_service
      set_service
      if !@service.matching_service.nil?&&(@service.creator_id==current_user.id||@service.matching_service.creator_id=current_user.id)
        if @service.creator_id==current_user.id
          @service=@service.matching_service
        end
      else
        dont_see
      end
    end
    def set_service
      if !user_signed_in?
        dont_see
      else
        @service = Service.find(params[:id])
      end
    end

    def create_quick_service
      @serviceQ=Service.new
      #TODO si on renseigne pas tous les champs, la vérif du modèle va gueuler.  Que faire ?  le boolean quick_match sert-il alors ?
      @serviceQ.title=@service.title
      @serviceQ.title=@service.title
      @serviceQ.description=@service.description
      @serviceQ.date_start=@service.date_start
      @serviceQ.date_end=@service.date_end
      @serviceQ.creator_id=current_user.id
      @serviceQ.quick_match=true
      @serviceQ.matching_service=@service
      @serviceQ.is_demand=@service.is_demand==true
      @serviceQ.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title,:description, :date_start, :date_end,:is_demand, :photo)
    end

    def transaction_params
      params.require(:transaction).permit(:feedback_comments, :feedback_evaluation)
    end
   

end
