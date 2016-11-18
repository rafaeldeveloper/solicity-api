require 'fcm'
class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    id = params[:id]
    categories = Category.all
    category_with_users = []
    categories.each { |cat|
      resp = {}
      resp["name"] = cat.name
      resp["amount_users"] = Service.where('category_id = ?', cat.id).count
      resp["url_image"] = cat.url_image
      resp["id"] = cat.id
      category_with_users << resp
    }
    render json: category_with_users, status: 200    
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    id = params[:id]
    resp = {}
    categorie = Category.find(id)
    resp["name"] = categorie.name
    resp["users"] = Service.where('category_id = ?', categorie.id)
    resp["url_image"] = categorie.url_image
    resp["id"] = categorie.id
    render json: resp, status: 200  
  end

  def push
    fcm = FCM.new("AIzaSyCHpYliEBSjDkeZU8F2a8ovNmDv31J6vg0")
    # you can set option parameters in here
    #  - all options are pass to HTTParty method arguments
    #  - ref: https://github.com/jnunemaker/httparty/blob/master/lib/httparty.rb#L29-L60
    #  fcm = FCM.new("my_api_key", timeout: 3)
    registration_ids= ["APA91bGuDgoj8VgLC0SMKGx3qDhFPoFDWRHcfiLcgPLJOiEeshhzZOhI5xRsKid5YYuqryEc3Ed19nse7ozjSF5kb8Be1KyIooSSabUhkgBsVBvEeJvnjHCTh8sh3xdYauR_-05T5tyt5_zArlrS0-oNBLHFqfLKFw"] # an array of one or more client registration tokens
    options = {data: {score: "123"}, collapse_key: "updated_score"}
    response = fcm.send(registration_ids,options)
    p response
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    if @category.save
      render :json=> {:success=>true, :category=>@category}  
    else
      render :json => {:success=>false, :message=>"failure on save category"}, :status=>200
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category = Category.new(category_params)
    if @category.update
      render :json=> {:success=>true, :category=>@category}  
    else
      render :json => {:success=>false, :message=>"failure on update category"}, :status=>200
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if @category.destroy
      render :json=> {:success=>true, :message=>"Category was successfully destroyed."}  
    else
      render :json=> {:success=>true, :message=>"failure on destroy category"}        
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :url_image)
    end
end
