class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    products = Product.search(params).page(params[:page]).per(params[:per_page])
    render json: products, meta: { pagination:
                                   { per_page: params[:per_page],
                                     total_pages: products.total_pages,
                                     total_objects: products.total_count } }
  end

  def show
    respond_with Product.find(params[:id])
  end
end
