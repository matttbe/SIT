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
  
  
  # GET /manage_organisation
  def manage
    @organisations = Organisation.where("creator_id=:id", :id=>current_user.id)
  end
  
  # GET /mainmenu_organisations/:id
  def show_main_panel
       if !user_signed_in?
            dont_see
       else
           @organisations = Organisation.joins(:coworkers).where("organisations.id=:org_id and coworkers.user_id=:user_id", :org_id=>params[:id], :user_id=>current_user.id)
           if @organisations.length == 0
                dont_see
           elsif !@organisations.first.validated?
                dont_see
           else
                @organisation = @organisations.first
           end
           
       end       
  end
  
  # GET /create_managed_user/:org_id
  def new_managed
     if !user_signed_in?
        dont_see        
     else
        @organisation = Organisation.find(params[:org_id])
        @user = User.new
        @user.managed_org_id = params[:org_id]
     end   
     
  end
  
  # POST /create_managed_user_filled
  # POST /create_managed_user_filled.json
  def create_managed
      @user = User.new(new_managed_params)
      @user.password = @user.name+@user.firstname+@user.name
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      string = (0...8).map{ o[rand(o.length)] }.join
      @user.email= @user.name + @user.firstname + string + '@solidateit.com'
      @user.inscription_ok=true
      respond_to do |format|
        if @user.save
          format.html { redirect_to mainmenu_organisations_path(@user.managed_org_id), notice: 'Managed user was successfully created.' }
        else
          format.html { redirect_to mainmenu_organisations_path(@user.managed_org_id), alert: @user.name }
        end
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
    
  # GET /choose_organisations
  def choose
    @organisations = current_user.organisations.all
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
            format.html { redirect_to @organisation, notice: 'You\'ve been added to coworkers list from ' +@organisation.name+'. Wait to be accepted'}
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
    
    def new_managed_params
      params.require(:user).permit(:name,:firstname,:birthdate,:managed_org_id)
    end
end
