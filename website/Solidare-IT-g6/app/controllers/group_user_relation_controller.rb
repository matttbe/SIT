class GroupUserRelationController < ApplicationController
  def new
	  if GroupUserRelation.where(user_id: current_user.id, group_id: params[:idGroup]).blank?
  		@relation = GroupUserRelation.new(user_id:params[:idUser] , group_id:params[:idGroup], role:params[:role])
  		respond_to do |format|
  			if @relation.save
  			  #TODO include user		  
          		format.html { redirect_to show_group_path(@relation.group), notice: "Welcome in the group"}
			else
			    format.html { redirect_to group_index_path(), notice: "an error occure"}
			end
	     end
	 else
		respond_to do |format|
		    format.html { redirect_to group_index_path, notice: "You are already in the group"}
		end
	 end
  end
end
