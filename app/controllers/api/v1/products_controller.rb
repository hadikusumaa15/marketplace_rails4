class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    products = params[:product_ids].present? ? Product.find(params[:product_ids]) : Product.all
    respond_with products
  end

  def show
    respond_with Product.find(params[:id])
  end
end
