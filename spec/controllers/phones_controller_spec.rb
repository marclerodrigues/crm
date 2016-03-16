require 'spec_helper'
require 'rails_helper'

RSpec.describe PhonesController, type: :controller do

  describe "GET #index" do
    it "populates an array of phones" do
      phone = FactoryGirl.create(:phone)
      get :index
      expect(assigns(:phones)).to eq([phone])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the request phone to @phone" do
      phone = FactoryGirl.create(:phone)
      get :show, id: phone
      expect(assigns(:phone)).to eq(phone)
    end

    it "renders the :show template" do
      get :show, id: FactoryGirl.create(:phone)
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new phone" do
        expect {
          post :create, phone: FactoryGirl.attributes_for(:phone)
        }.to change(Phone, :count).by(1)
      end
      it "redirects to new phone" do
        post :create, phone: FactoryGirl.attributes_for(:phone)
        expect(response).to redirect_to Phone.last
      end
    end

    context "with invalid attributes" do
      it "does not save a new phone" do

      end
      it "re-renders the :new template"
    end
  end

end
