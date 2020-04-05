require 'spec_helper'

describe Api::V1::ProductsController do
  describe "GET #show" do
    before(:each) do
      @product = FactoryGirl.create :product
      get :show, id: @product.id
    end

    it "returns the information about a reporter on a hash" do
      product_response = json_response
      expect(product_response[:title]).to eql @product.title
    end

    it { should respond_with 200 }

    it "has the user as a embeded object" do
      product_response = json_response
      expect(product_response[:user][:email]).to eql @product.user.email
    end
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :product } 
    end

    context "when is not receiving any product_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        products_response = json_response

        expect(products_response).to have(4).items
      end

      it "returns the user object into each product" do
        products_response = json_response
        products_response.each do |product_response|
          expect(product_response[:user]).to be_present
        end
      end

      it { should respond_with 200 }
    end

    context "when product_ids parameter is sent" do
      before(:each) do
        @user = FactoryGirl.create :user
        3.times { FactoryGirl.create :product, user: @user }
        get :index, product_ids: @user.product_ids
      end

      it "returns just the products that belong to the user" do
        products_response = json_response
        products_response.each do |product_response|
          expect(product_response[:user][:email]).to eql @user.email
        end
      end
    end
  end
end
# brspec spec/controllers/api/v1/products_controller_spec.rb