class OrganisationsController < InheritedResources::Base
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]
  
  # GET /organisations/new
  def new
    if user_signed_in?
      @organisation = Organisation.new
    else
      dont_see
    end

  end
  
  def show
     protect_param_integer
    if @can
      @organisation = Organisation.find(params[:id])
    end
  end
  
  # GET /join_organisations
  def join_organisation
    if user_signed_in?
      @organisations = Organisation.all
    else
      dont_see
    end
  end
  
  # GET /manage_organisation
  def manage
    @organisations = Organisation.all
  end
    
  
  # GET /join_organisation/:id
  def join_action
    @organisation = Organisation.find(params[:id])
    @coworker = Coworker.new
    @coworker.user = current_user
    @coworker.organisation = @organisation
    @organisation.coworkers << @coworker
    respond_to do |format|
        if @organisation.save
            format.html { redirect_to @organisation, notice: 'You\'ve been added to coworkers from ' +@organisation.name+'. Wait to be accepted'}
        else
            show_error(format,'new',@coworker)
        end
    end
  end
  
  # POST /organisations
  # POST /organisations.json
  def create
      @organisation = Organisation.new(organisation_params)
      @organisation.creator_id=current_user.id
      respond_to do |format|
        if @organisation.save
          @coworker = Coworker.new
          @coworker.user = current_user
          @coworker.organisation = @organisation
          if @coworker.save
              format.html { redirect_to @organisation, notice: 'Organisation was successfully created.' }
              format.json { render action: 'show', status: :created, location: @organisation }
          else
              show_error(format,'new',@coworker)
          end
        else
          show_error(format,'new',@organisation)
        end
      end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organisation_params
      params.require(:organisation).permit(:name)
    end

end
