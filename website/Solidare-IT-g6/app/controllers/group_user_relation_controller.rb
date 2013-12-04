class GroupUserRelationController < ApplicationController
  def new
	  if GroupUserRelation.where(user_id: current_user.id, group_id: params[:idGroup]).blank?
  		@relation = GroupUserRelation.new(user_id:params[:idUser] , group_id:params[:idGroup], role:params[:role])
  		respond_to do |format|
  			if @relation.save
				format.json { render json: @relation}
			else
				format.json { render json: {:error => "error"}}
			end
	     end
	 else
		respond_to do |format|
		  format.json { render json: {:error => "Already in group"}}
		end
	 end
  end
end
