class OrganisationsController < InheritedResources::Base
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organisation_params
      params.require(:org).permit(:name)
    end

end
