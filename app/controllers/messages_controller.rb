class MessagesController < ApplicationController

	def set_app_id
		user = User.find(params[:user_id])
		if user
			app_id = params[:app_id];
			unless app_id
				return render :json=> {:success=>false,:message=>"Error on register app id missing"}
			end
			user.app_id = app_id
			if user.save
	        return render :json=> {:success=>true,:message=>"App id #{app_id} registered"}
			else
	        return render :json=> {:success=>false,:message=>"Error on register app id"}
			end
		end
	end
  

end

