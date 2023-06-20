class ItemsController < ApplicationController
 rescue_from ActiveRecord::RecordNotFound, with: :not_found_response 

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else  
      items = Item.all
    end
    render json: items, include: :user
  end

  def show 
    item = Item.find(params[:id])
    render json: item
  end

  def create
    item = Item.create(params.permit(:name, :description, :price, :user_id))
    render json: item, status: :created
  end

  private

  def not_found_response
    render json: {errors: "Review not found"}, status: :not_found
  end

end
