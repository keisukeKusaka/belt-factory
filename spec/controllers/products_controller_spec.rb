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
end
