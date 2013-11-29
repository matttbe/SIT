class GroupUserRelationController < ApplicationController
  def new
  	@relation = GroupUserRelation.new(user_id:params[:idUser] , group_id:params[:idGroup])
  	#TODO check if the relation already exists
  	respond_to do |format|
  		if @relation.save
			format.json { render json: @relation}
		else
			format.json { render json: {:error => "error"}} #TODO 
		end
    end
       
  end
end
