require 'rails_helper'

describe ProductsController do
  let(:client) { create(:client) }
  let(:department) { create(:department, id: 2)}
  let(:user) { create(:user, department_id: department.id) }

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

    it '@new_idに期待される文字列が代入されている' do
      expect(assigns(:new_number)).to eq ("%06d" % (Product.maximum(:number).to_i + 1))
    end
  end
end
