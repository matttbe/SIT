class GroupUserRelationController < ApplicationController
  def new
	  if GroupUserRelation.where(user_id: current_user.id, group_id: params[:idGroup]).blank?
  		@relation = GroupUserRelation.new(user_id:params[:idUser] , group_id:params[:idGroup])
  		respond_to do |format|
  			if @relation.save
  			  #TODO include user
  			  
      format.html { redirect_to show_group(@relation.group.id), notice: "Welcome in the group"}
				#format.json { render json: @relation.user}
			else
			    format.html { redirect_to group_index_path(@relation.group.id), notice: "an error occure"}
				#format.json { render json: {:error => "error"}}
			end
	     end
	 else
		respond_to do |format|
		    format.html { redirect_to group_index_path, notice: "You are already in the group"}
		 # format.json { render json: {:error => "Already in group"}}
		end
	 end
  end
end
