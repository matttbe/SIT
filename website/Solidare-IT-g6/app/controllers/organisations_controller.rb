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
  
  # POST /organisations
  # POST /organisations.json
  def create
      @organisation = Organisation.new(organisation_params)
      #@organisation.creator_id=current_user.id

      respond_to do |format|
        if @organisation.save
          format.html { redirect_to @organisation, notice: 'organisation was successfully created.' }
          format.json { render action: 'show', status: :created, location: @organisation }
        else
          show_error(format,'new')
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
    
    def show_error(format,actionName)
      format.html { render action: actionName }
      format.json { render json: @organisation.errors, status: :unprocessable_entity }
    end

end
