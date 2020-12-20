require 'rails_helper'

describe ProductsController do
  include ApplicationHelper
  let(:client) { create(:client) }
  let(:material) { create(:material) }
  let(:department) { create(:department, id: 2)}
  let(:user) { create(:user, department_id: department.id) }
  let(:product) { create(:product, client_id: client.id, material_id: material.id, user_id: user.id) }
  let(:production_datum) { create(:production_datum, user_id: user.id, product_id: product.id) }

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

    it '@productsにProductモデルのレコードが降順で代入されている' do
      expect(assigns(:products)).to eq Product.all.reverse
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

      it '現在のページ（root_path）へリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#filter" do
    context 'clientとmaterialの両方を指定した場合' do
      before do
        get :filter, params: { client_id: client.id, material_id: material.id }
      end

      it '@productsに期待される文字列が代入されている' do
        expect(assigns(:products)).to eq Product.where(material_id: material.id).where(client_id: client.id).reverse
      end

      it 'filter_products_pathへ遷移する' do
        expect(response).to render_template :filter
      end
    end

    context 'clientのみ指定した場合' do
      before do
        get :filter, params: { client_id: client.id, material_id: nil }
      end

      it '@productsに期待される文字列が代入されている' do
        expect(assigns(:products)).to eq Product.where(client_id: client.id).reverse
      end

      it 'filter_products_pathへ遷移する' do
        expect(response).to render_template :filter
      end
    end

    context 'materialのみ指定した場合' do
      before do
        get :filter, params: { client_id: nil, material_id: material.id }
      end

      it '@productsに期待される文字列が代入されている' do
        expect(assigns(:products)).to eq Product.where(client_id: client.id).reverse
      end

      it 'filter_products_pathへ遷移する' do
        expect(response).to render_template :filter
      end
    end

    context 'clientとmaterialのどちらも空欄の場合' do
      before do
        get :filter, params: { client_id: nil, material_id: nil }
      end

      it 'root_pathに遷移する' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#show" do
    subject {
      get :show, params: { id: product.id }
    }

    it '@productに期待される文字列が代入されている' do
      subject
      expect(assigns(:product)).to eq Product.find(product.id)
    end

    context 'productに紐づけられているproduction_datumのデータが存在する場合' do
      it '@production_datumに@product.production_datumが代入されている' do
        get :show, params: { id: product.id, production_datum: production_datum }
        expect(assigns(:production_datum)).to eq product.production_datum
      end
    end

    context 'productに紐づけられているproduction_datumのデータが存在しない場合' do
      it '@production_datumにProductionDatum.newが代入されている' do
        subject
        expect(assigns(:production_datum)).to be_a_new(ProductionDatum)
      end

      it '@inspection_datumにInspectionDatum.newが代入されている' do
        subject
        expect(assigns(:inspection_datum)).to be_a_new(InspectionDatum)
      end

      it '@evaluation_datumにEvaluationDatum.newが代入されている' do
        subject
        expect(assigns(:evaluation_datum)).to be_a_new(EvaluationDatum)
      end
    end
  end

  describe "#edit" do
    context '@productに紐づけられているproduction_datumのデータが存在する場合' do
      before do
        get :edit, params: { id: product.id , production_datum: production_datum}
      end

      it 'product_path(@product)へリダイレクトする' do
        expect(response).to redirect_to(product_path(product))
      end
    end

    context '@productに紐づけられているproduction_datumのデータが存在しない場合' do
      before do
        get :edit, params: { id: product.id }
      end

      it '@productに期待される文字列が代入されている' do
        expect(assigns(:product)).to eq Product.find(product.id)
      end

      it 'edit.html.hamlに遷移する' do
        expect(response).to render_template :edit
      end
    end
  end

  describe "#update" do
    context 'productに紐づけられているproduction_datumのデータが存在する場合' do
      before do
        product_params = { length: 43.21 }
        patch :update, params: { id: product.id, production_datum: production_datum, product: product_params}
      end

      it 'productを更新できない' do
        expect(product.reload.length).to eq 12.34
      end

      it 'product_path(product)へリダイレクトする' do
        expect(response).to redirect_to(product_path(product))
      end
    end

    context 'productに紐づけられているproduction_datumのデータが存在しない場合' do
      before do
        product_params = { length: 43.21 }
        patch :update, params: { id: product.id, product: product_params }
      end

      it 'productを更新できている' do
        expect(product.reload.length).to eq 43.21
      end

      it 'product_path(@product)へリダイレクトする' do
        expect(response).to redirect_to(product_path(product))
      end
    end
  end

  describe "#destroy" do
    subject {
      delete :destroy, params: { id: product }
    }

    context 'productに紐づけられているproduction_datumのデータが存在する場合' do
      before do
        product = attributes_for(:product, production_datum: production_datum)
      end

      it 'productは削除されていない' do
        expect do
          subject
        end.to change(Product, :count).by(0)
      end

      it 'product_path(product)へリダイレクトする' do
        subject
        expect(response).to redirect_to(product_path(product))
      end
    end

    context 'productに紐づけられているproduction_datumのデータが存在しない場合' do
      before do
        product_params = attributes_for(:product)
        product.reload
      end

      it 'productを削除できている' do
        expect do
          subject
        end.to change{Product.ids.count}.by(-1)
      end

      it 'root_pathに遷移する' do
        subject
        expect(response).to redirect_to root_path
      end
    end
  end
end
