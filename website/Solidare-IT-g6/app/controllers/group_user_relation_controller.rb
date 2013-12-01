class GroupUserRelationController < ApplicationController
  def new
	  if GroupUserRelation.where(user_id: current_user.id, group_id: params[:idGroup]).blank?
  		@relation = GroupUserRelation.new(user_id:params[:idUser] , group_id:params[:idGroup])
  		respond_to do |format|
  			if @relation.save
				format.json { render json: @relation}
			else
				format.json { render json: {:error => "error"}} #TODO 
			end
	     end
      end
  end
end
