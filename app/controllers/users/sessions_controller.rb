class Users::SessionsController < Devise::SessionsController
  # skip_before_filter :check_token
# before_action :configure_sign_in_params, only: [:create]
  skip_before_filter :check_token
  respond_to :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def require_no_authentication
  end

  def sync
    if params.key? :authentication_token
        token = params[:authentication_token]
        id = params[:id]
        user = User.find_for_database_authentication(authentication_token: token)
        if user
          response  = {}
          response['profile'] = user
          cats = Category.all
          category_with_users = []
          cats.each { |cat|
            resp = {}
            resp["name"] = cat.name
            resp["amount_users"] = Service.where('category_id = ?', cat.id).count
            resp["url_image"] = cat.url_image
            resp["id"] = cat.id
            category_with_users << resp
          }
          response['categories'] = category_with_users
          users = User.all
          professionals = []
          users.each { |user|
            resp = {}
            user_categories = Service.where('user_id = ?', user.id)
            if user_categories.any?
                categories = [] 
                user_categories.each { |cat|
                  categories << cat.category_id
                }
                resp['id'] = user.id
                resp['email'] = user.email
                resp['site'] = user.site
                resp['url_image'] = user.url_image
                resp['phone'] = user.phone
                resp['cpf'] = user.cpf
                resp['first_name'] = user.first_name
                resp['last_name'] = user.last_name
                resp['categories'] = categories
                professionals << resp
            end
          }
          response['professionals'] = professionals

          render json: response, status: 200 
        else
          invalide_token
        end
    else
      invalide_token
    end 
  end

  def create
    resource = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless resource
    if resource.valid_password?(params[:password])
      sign_in("user", resource)
       render :json=> {:success=>true, :user=>resource}
    else
      invalid_login_attempt
    end  
  end


  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:registration, keys: [:email,:password])
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json => {:success=>false, :message=>"Error with your login or password"}, :status=>200
      
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
