class LaptopsController < ApplicationController
  before_action :authenticate_user!

  def index
    laptops = Laptop.all

    render json: laptops
  end

  def create
    laptop = Laptop.new(laptop_params)
    laptop.user = current_user

    if laptop.save
      render json: laptop, status: :created
    else
      render json: laptop.errors, status: :unprocessable_entity
    end
  end

  def show
    laptop = Laptop.find(params[:id])
    render json: laptop
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Laptop not found' }, status: :not_found
  end

  def destroy
    laptop = Laptop.find(params[:id])
    laptop.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Laptop not found' }, status: :not_found
  end

  private

  def laptop_params
    params.require(:laptop).permit(:name, :price, :cpu, :memory, :storage)
  end
end
