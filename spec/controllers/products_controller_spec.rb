require 'rails_helper'

describe ProductsController do
  include ApplicationHelper
  let(:client) { create(:client) }
  let(:material) { create(:material) }
  let(:department) { create(:department, id: 2)}
  let(:user) { create(:user, department_id: department.id) }
  let(:product) { create(:product, client_id: client.id, material_id: material.id, user_id: user.id) }

  before do
    login user
  end

  describe "#index" do
    before do
      get :index
    end

    it 'index.html.hamlに遷移する' do
      expect(response).to render_template :index
    end
  end

  describe "#new" do
    before do
      get :new
    end

    it 'new.html.hamlに遷移する' do
      expect(response).to render_template :new
    end

    it '@productにProduct.newが代入されている' do
      expect(assigns(:product)).to be_a_new(Product)
    end

    it '@clientにClient.allが代入されている' do
      expect(assigns(:client)).to eq Client.all
    end

    it '@materialにMaterial.allが代入されている' do
      expect(assigns(:material)).to eq Material.all
    end

    it '@new_numberに期待される文字列が代入されている' do
      expect(assigns(:new_number)).to eq ("%06d" % (Product.maximum(:number).to_i + 1))
    end
  end

  describe "#create" do
    before do
      product_params = attributes_for(:product)
      post :create, params: { product: product_params }
    end

    it '@productにProduct.newが代入されている' do
      expect(assigns(:product)).to be_a_new(Product)
    end

    it 'new.html.hamlに遷移する' do
      expect(response).to redirect_to(new_product_path)
    end
  end

  describe "#search" do
    context "検索が成功した場合" do
      before do
        get :search, params: { number: product.number }
      end

      it '@productに期待される文字列が代入されている' do
        expect(assigns(:product)).to eq Product.find_by(product.number)
      end

      it 'product_path(@product)へリダイレクトする' do
        expect(response).to redirect_to(product_path(product))
      end
    end

    context "検索が失敗した場合" do
      before do
        get :search, params: { number: nil }
      end

      it 'search_products_pathへリダイレクトする' do
        expect(response).to render_template :search
      end
    end

    describe "#show" do
      before do
        get :show, params: { id: product.id }
      end

      it '@productに期待される文字列が代入されている' do
        expect(assigns(:product)).to eq Product.find(product.id)
      end

      it 'create_product_design(@product)が行われている' do
        expect(assigns(:product)).to eq Product.find(product.id)
      end

    end
  end
end
