require 'rails_helper'

describe InspectionDataController do
  let(:client) { create(:client) }
  let(:material) { create(:material) }
  let(:department) { create(:department, id: 1)}
  let(:user) { create(:user, department_id: department.id) }
  let(:product) { create(:product, client_id: client.id, material_id: material.id, user_id: user.id) }
  let(:inspection_datum) { create(:inspection_datum, user_id: user.id, product_id: product.id) }

  before do
    login user
  end

  describe "#create" do
    context '入力が適切な場合' do
      subject {
        post :create, params: { product_id: product.id, user_id: user.id, inspection_datum: attributes_for(:inspection_datum) }
      }

      it '正常に動作しているか' do
        subject
        expect(response.status).to eq(302)
      end

      it 'アクションで定義した変数にInspectionDatum.newが代入されている' do
        subject
        expect(assigns(:inspection_datum)).to be_a_new(InspectionDatum)
      end

      it 'inspection_datumが保存されている' do
        expect{ subject }.to change( InspectionDatum, :count ).by(1)
      end

      it 'product_path(@product)に遷移する' do
        expect(subject).to redirect_to(product_path(product))
      end
    end
    context '入力が不適切な場合' do
      subject {
        post :create, params: { product_id: product.id, user_id: user.id, inspection_datum: attributes_for(:inspection_datum, comment: nil) }
      }

      it 'inspection_datumが保存されない' do
        expect{ subject }.to change( InspectionDatum, :count ).by(0)
      end

      it 'product_path(@product)に遷移する' do
        expect(subject).to redirect_to(product_path(product))
      end
    end
  end

  describe "#update" do
    subject {
      inspection_datum_params = { comment: "コメントのアップデート" }
      patch :update, params: { id: inspection_datum.id, product_id: product.id, user_id: user.id, inspection_datum: inspection_datum_params }
    }

    it 'productを更新できている' do
      subject
      expect(inspection_datum.reload.comment).to eq "コメントのアップデート"
    end

    it 'product_path(@product)に遷移する' do
      expect(subject).to redirect_to(product_path(product))
    end
  end
end
