class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy, :accept_service]


  # GET /user/services
  def my_services
    if user_signed_in?
      @services = current_user.own_services.order(:is_demand)#Service.where('creator_id = (:id)',
               #:id => current_user.id).order_by("Service.is_demand")
    else
      dont_see
    end
  end

  # GET /services/:id/accept
  def accept_service
    if @service.matching_service.nil?
      create_quick_service
      @service.matching_service=@serviceQ
      respond_to do |format|
        format.html { redirect_to my_services_path, notice: 'you have accepted a service' }
      end
    else
      #TODO adding to the follow list
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
      @service.is_demand=(params["service.demand"]=="demand")

      respond_to do |format|
        if @service.save
          format.html { redirect_to @service, notice: 'Service was successfully created.' }
          format.json { render action: 'show', status: :created, location: @service }
        else
          format.html { render action: 'new' }
          format.json { render json: @service.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    if !(@service.creator_id==current_user.id)
      dont_see
    else
      respond_to do |format|
        if @service.update(service_params)
          format.html { redirect_to @service, notice: 'Service was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @service.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
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
      params.require(:service).permit(:title,:description, :date_start, :date_end,:demand)
    end
end