class AddressController < ApplicationController
    
    before_action :is_logged_in, only: [:main, :new,:create,:index, :update, :destroy, :show]
    before_action :set_address, only: [:main,:edit,:show, :destroy,:update]

    def new
        @address = Address.new
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
      if params[:org_id] == nil
        if params[:man_id] == nil
          @address.user_id=current_user.id
        else
          @address.user_id=params[:man_id]    
        end
      else
        @address.orga_id = params[:org_id]
      end

      coordinates = Geokit::Geocoders::Google3Geocoder.geocode(@address.street + ", " + @address.number.to_s + ", " + @address.country)
      @address.latitude = coordinates.lat
      @address.longitude = coordinates.lng

      respond_to do |format|
        if @address.latitude.nil?
            format.html { render action: 'wrong_zip_new' }
        else
          if @address.save
              format.html { redirect_to address_index_path, notice: 'Address was successfully created.' }
              format.json { render action: 'show', status: :created, location: @address }
          else
              show_error(format,'new',@address)
          end
        end
      end
    
    end

    def show
    end
    
    def index
        #TODO quand julien aura rajoute les orga, faudra les gérer
        @addresses = current_user.addresses.order(principal: :desc)
    end
    
    def edit
      if @address.user_id!=current_user.id
        can_do_that
      end

    end
    
    def update
        if !(@address.user_id==current_user.id)
            can_do_that
        else
            respond_to do |format|
                @tmp = Address.new(address_params)
                coordinates = Geokit::Geocoders::Google3Geocoder.geocode(@tmp.street + ", " + @tmp.number.to_s + ", " + @tmp.country)
                if coordinates.lat.nil?
                    format.html { render action: 'wrong_zip_edit' }
                else
                    if @address.update(address_params)                    
                        @address.latitude = coordinates.lat
                        @address.longitude = coordinates.lng
                        @address.save
                        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
                        format.json { head :no_content }
                        @tmp.destroy
                    
                    else
                        show_error(format,'edit',@address)
                    end
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

    private 
    def address_params
        params.require(:address).permit(:street, :number, :postal_code, :city, :country, :principal)
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
