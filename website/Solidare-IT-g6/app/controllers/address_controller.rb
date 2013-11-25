class AddressController < ApplicationController

    def create
      @address = Service.new(service_params)
      #TODO how to know if the current_user is a User or an Organisation ?
      @address.user_id = current_user.id
      @address.save #TODO handle error
    end

    def service_params
        params.require(:address).permit(:street, :number, :postal_code, :city, :country)
    end
    
end
