class ApplicationController < ActionController::Base
  # acts_as_token_authentication_handler_for User
  # before_action :check_token

  respond_to :json,:html


  def invalide_token
    render :json => {:success=>false, :message=>"Invalid Token"}, :status=>200
  end

  def check_token
 		if params.key? :authentication_token
        token = params[:authentication_token]
        user = User.find_for_database_authentication(authentication_token: token)
        if user
        	p "token authenticated"
        else
          invalide_token
        end
    else
      invalide_token
    end    
  end

end
