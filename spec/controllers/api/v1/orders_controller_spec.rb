require 'spec_helper'

describe Api::V1::OrdersController do
  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 order records from the user" do
      orders_response = json_response
      expect(orders_response).to have(4).items
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token

      @product = FactoryGirl.create :product
      @order = FactoryGirl.create :order, user: current_user, product_ids: [@product.id]
      get :show, user_id: current_user.id, id: @order.id
    end

    it "returns the user order record matching the id" do
      order_response = json_response
      expect(order_response[:id]).to eql @order.id
    end

    it "includes the total for the order" do
      order_response = json_response
      expect(order_response[:total]).to eql @order.total.to_s
    end
  
    it "includes the products on the order" do
      order_response = json_response
      expect(order_response[:products]).to have(1).item
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token

      product_1 = FactoryGirl.create :product
      product_2 = FactoryGirl.create :product
      order_params = { total: 50, user_id: current_user.id, product_ids: [product_1.id, product_2.id] }
      post :create, user_id: current_user.id, order: order_params
    end

    it "returns the just user order record" do
      order_response = json_response
      expect(order_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end

  describe '#set_total!' do
    before(:each) do
      product_1 = FactoryGirl.create :product, price: 100
      product_2 = FactoryGirl.create :product, price: 85

      @order = FactoryGirl.build :order, product_ids: [product_1.id, product_2.id]
    end

    it "returns the total amount to pay for the products" do
      expect{@order.set_total!}.to change{@order.total}.from(0).to(185)
    end
  end
end
# brspec spec/controllers/api/v1/orders_controller_spec.rb