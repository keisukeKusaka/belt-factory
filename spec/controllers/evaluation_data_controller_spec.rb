require 'rails_helper'

describe EvaluationDataController do
  let(:client) { create(:client) }
  let(:material) { create(:material) }
  let(:department) { create(:department, id: 2)}
  let(:user) { create(:user, department_id: department.id) }
  let(:product) { create(:product, client_id: client.id, material_id: material.id, user_id: user.id) }
  let(:evaluation_datum) { create(:evaluation_datum, user_id: user.id, product_id: product.id) }

  before do
    login user
  end

  describe "#create" do
    context '入力が適切な場合' do
      subject {
        post :create, params: { product_id: product.id, user_id: user.id, evaluation_datum: attributes_for(:evaluation_datum) }
      }

      it '正常に動作しているか' do
        subject
        expect(response.status).to eq(302)
      end

      it 'アクションで定義した変数にEvaluationDatum.newが代入されている' do
        subject
        expect(assigns(:evaluation_datum)).to be_a_new(EvaluationDatum)
      end

      it 'evaluation_datumが保存されている' do
        expect{ subject }.to change( EvaluationDatum, :count ).by(1)
      end

      it 'product_path(@product)に遷移する' do
        expect(subject).to redirect_to(product_path(product))
      end
    end
    context '入力が不適切な場合' do
      subject {
        post :create, params: { product_id: product.id, user_id: user.id, evaluation_datum: attributes_for(:evaluation_datum, comment: nil) }
      }

      it 'evaluation_datumが保存されない' do
        expect{ subject }.to change( EvaluationDatum, :count ).by(0)
      end

      it 'product_path(@product)に遷移する' do
        expect(subject).to redirect_to(product_path(product))
      end
    end
  end
end
