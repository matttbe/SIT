class AddressController < ApplicationController
      before_action :is_logged_in, only: [:create]

    def create
      @address = Address.new(address_params)
      #TODO how to know if the current_user is a User or an Organisation ?
      @address.user_id = current_user.id
      
      respond_to do |format|
        if @address.save
          format.html { redirect_to @address, notice: 'Address was successfully created.' }
          format.json { render action: 'show', status: :created, location: @address }
        else
          show_error(format,'new')
        end
      end
      
    end

    private 
    def address_params
        params.require(:address).permit(:street, :number, :postal_code, :city, :country)
    end
    
    def is_logged_in
        if !user_signed_in?
            dont_see
        end
    end
    
end
