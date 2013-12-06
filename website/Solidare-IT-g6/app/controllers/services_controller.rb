class ServicesController < ApplicationController
  before_action :set_service, only: [:edit, :update, :destroy, :share, :accept_service, :follow, :unfollow]
  before_action :set_good_service, only: [:create_transaction, :new_transaction]
  
  helper_method :get_accepters

  #GET /following_services
  def following_services
    if user_signed_in?
      @following = Follower.where("user_id = :user_id", :user_id => current_user.id)      
    end
  end

  # GET /user/services
  def my_services
    if user_signed_in?
      @services = current_user.own_services.order(:is_demand)
	  @pending_services = Service.joins(:accept_services).where(accept_services: {user_id: current_user.id,is_chosen_customer: false})
	  @accepted_services = Service.joins(:accept_services).where(accept_services: {user_id: current_user.id,is_chosen_customer: true})
    else
      dont_see
    end
  end

  # GET /services/:id/accept
  def accept_service
	#TODO check doublon (not supposed to happen technically => button not shown if already accepted) 
	@accept_service = AcceptService.new()
	@accept_service.service_id = @service.id
	@accept_service.user_id = current_user.id
	@accept_service.is_chosen_customer = false
	@accept_service.save
    if @service.matching_service.nil?
      notify_owner(@service, 'ACCEPT')
      notify(@service, 'ACCEPT')
      respond_to do |format|
        expire_fragment(@service)
        format.html { redirect_to my_services_path(current_user), notice: 'you have accepted a service' }
      end
    else
      #TODO verify this generated error
      show_error(format,'services/show',@service)
    end
  end

  def choose
	@chosen_service = AcceptService.where(user_id: params[:u_id],service_id: params[:s_id]).first

	#remove old accepted customer (not used anymore since we can only chose once ! But we leave it for robustness, shouldn't have any effect though)
	#olds = AcceptService.where(service_id: @chosen_service.service_id, is_chosen_customer: true)
	#olds.each do |old|
	#	if not old.id == @chosen_service.id
	#		old.is_chosen_customer = false
	#		old.save
	#	end
	#end 

	@chosen_service.is_chosen_customer = true
	@chosen_service.save

	@service = Service.find(params[:s_id])
    create_quick_service(@chosen_service.user_id)
    @service.matching_service=@serviceQ
	@service.save!

	respond_to do |format|
        format.html { redirect_to my_services_path(params[:u_id]), notice: 'User chosen !' }
	end
  end

  # GET /services
  # GET /services.json
  def index
    respond_to do |format|
        format.html { redirect_to match_path }
        format.json { redirect_to match_path }
        format.js {redirect_to match_path(params[:page])}
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
    @users = User.all 
    end
  end

  # GET /services/new
  #  /users_managed/:serv_id/services/new
  def new
    if user_signed_in?
      @service = Service.new
      if params[:serv_id]== nil 
            @service.creator_id=current_user.id
      else
            @service.creator_id = params[:serv_id]
      end
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
      notify(@service, 'EDIT')
      respond_to do |format|
        if @service.update(service_params)
          expire_fragment(@service)
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
      @notifications = Notification.where("service_id = :service_id", :service_id => @service.id)
      @notifications.each do |notif|
        notif.destroy
      end
      
      @followers = Follower.where("service_id = :service_id", :service_id => @service.id)
      @followers.each do |follower|
        follower.destroy
      end
      
      @service.destroy
      expire_fragment(@service)
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
	@transaction.poster_id=current_user.id
    @user=User.find(@transaction.user_id)
    @user.karma=@user.karma+@transaction.feedback_evaluation
    #TODO update karma
    respond_to do |format|
       if @transaction.save && @user.save
           expire_fragment(@service)
           give_badge_transaction(@transaction)
           format.html { redirect_to my_services_path(@user), notice: 'thanks for your feedback !' }
           format.json { head :no_content }
       else
         #TODO have a red error message
         format.html { redirect_to my_services_path(@user), notice: 'An error occur while saving feedback!' }
       end
     end
  end
  
  def follow   
    if user_signed_in?
      @followers = Follower.where(:service_id => @service.id).where(:user_id => current_user.id)
      if @followers.empty?
        notify_owner(@service, 'FOLLOW')
        @follower = Follower.new
        @follower.service = @service
        @follower.user = current_user
        respond_to do |format|
          if @follower.save
            format.html{redirect_to request.referer, notice: 'You follow the service'}
          else
            show_error(format, 'services/show', @follower)
          end
        end
      end
    else
      dont_see
    end
 end
    
  def unfollow
    @follower = Follower.find(params[:follower_id])
    respond_to do |format|    
    notify_owner(@service, 'UNFOLLOW')
      if @follower.destroy        
        format.html{redirect_to request.referer, notice: 'Service unfollow'}
      else
        show_error(format, 'show', @follower)
      end
    end
  end
  
  def share
    
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

    def create_quick_service(user_id)
      @serviceQ=Service.new
      #TODO si on renseigne pas tous les champs, la vérif du modèle va gueuler.  Que faire ?  le boolean quick_match sert-il alors ?
      @serviceQ.title=@service.title
      @serviceQ.description=@service.description
      @serviceQ.date_start=@service.date_start
      @serviceQ.date_end=@service.date_end
      @serviceQ.creator_id=user_id
      @serviceQ.quick_match=true
      @serviceQ.matching_service=@service
      @serviceQ.is_demand=@service.is_demand==true
      @serviceQ.save!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:category_id,:title,:description, :date_start, :date_end,:is_demand, :photo, :creator_id)
    end

    def transaction_params
      params.require(:transaction).permit(:feedback_comments, :feedback_evaluation)
    end
   

end
