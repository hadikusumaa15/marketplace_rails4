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
      get :index
    end

    it "returns 4 records from the database" do
      products_response = json_response
      expect(products_response.count).to eq 4
    end

    it { should respond_with 200 }

    it "returns the user object into each product" do
      products_response = json_response
      products_response.each do |product_response|
        expect(product_response[:user]).to be_present
      end
    end
  end
end
# brspec spec/controllers/api/v1/products_controller_spec.rb