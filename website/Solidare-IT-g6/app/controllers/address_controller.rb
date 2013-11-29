class AddressController < ApplicationController
    before_action :is_logged_in, only: [:main, :new,:create,:index, :update, :destroy, :show]
    before_action :set_address, only: [:main,:edit,:show, :destroy,:update]

    def new
        @address =Address.new
    end

    def main
      current_user.addresses.each do |address|
        address.principal=false
        address.save
      end
      @address.principal=true
      respond_to do |format|
        if @address.save
          format.html { redirect_to address_index_path, notice: 'You have change your main address !' }
          format.json { head :no_content }
          else
            show_error(format,address_index_path,@address)
            end
      end
    end
    
    def create
      @address = Address.new(address_params)
      @address.user_id=current_user.id

      if current_user.addresses.nil?
        @address.principal=true
      end

      respond_to do |format|
        if @address.save
          format.html { redirect_to @address, notice: 'Address was successfully created.' }
          format.json { render action: 'show', status: :created, location: @address }
        else
          show_error(format,'new',@address)
        end
      end
    
    end

    def show
    end
    
    def index
        #TODO quand julien aura rajoute les orga, faudra les gérer
        @addresses = current_user.addresses
        
    end
    
    def update
        if !(@address.user_id==current_user.id)
            dont_see
        else
            respond_to do |format|
                if @address.update(address_params)
                    format.html { redirect_to @address, notice: 'Address was successfully updated.' }
                    format.json { head :no_content }
                else
                    show_error(format,'edit',@address)
                end
            end
        end
    end
    
    def destroy
        if !(@address.user_id==current_user.id)
            dont_see
        else
            @address.destroy
            respond_to do |format|
                format.html { redirect_to address_index_path }
                format.json { head :no_content }
            end
        end
    end

    
    def create
      @address = Address.new(address_params)
      #TODO how to know if the current_user is a User or an Organisation ?
      @address.user_id = current_user.id
      
      respond_to do |format|
        if @address.save
          format.html { redirect_to @address, notice: 'Address was successfully created.' }
          format.json { render action: 'show', status: :created, location: @address }
        else
          show_error(format,'new',@adress)
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

    def set_address
      @address = Address.find(params[:id])
    end
    
end