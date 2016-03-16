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
        expect {
          post :create, phone: FactoryGirl.attributes_for(:invalid_phone)
        }.not_to change(Phone, :count)
      end
      it "re-renders the :new template" do
        post :create, phone: FactoryGirl.attributes_for(:invalid_phone)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    before :each do
      @phone = FactoryGirl.create(:phone, phone_type: "mobile", number: "44 444 4444")
    end

    context "valid attributes" do

      it "located request @phone" do
        put :update, id: @phone, phone: FactoryGirl.attributes_for(:phone)
        expect(assigns(:phone)).to eq(@phone)
      end

      it "changes @phone attributes" do
        put :update, id: @phone, phone: FactoryGirl.attributes_for(:phone, phone_type: "work")
        @phone.reload
        expect(@phone.phone_type).to eq("work")
      end

      it "redirect to updated phone" do
        put :update, id: @phone, phone: FactoryGirl.attributes_for(:phone)
        expect(response).to redirect_to @phone
      end
    end

    context "invalid attributes" do

      it "located request @phone" do
        put :update, id: @phone, phone: FactoryGirl.attributes_for(:invalid_phone)
        expect(assigns(:phone)).to eq(@phone)
      end

      it "does not changes @phone attributes" do
        put :update, id: @phone, phone: FactoryGirl.attributes_for(:invalid_phone, phone_type: "home")
        @phone.reload
        expect(@phone.phone_type).to eq("mobile")
      end

      it "re-render edit method" do
        put :update,id: @phone, phone: FactoryGirl.attributes_for(:invalid_phone)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @phone = FactoryGirl.create(:phone)
    end

    it "deletes the phone" do
      expect {
        delete :destroy, id: @phone
      }.to change(Phone, :count).by(-1)
    end
    it "redirect to phone#index" do
        delete :destroy, id: @phone
        expect(response).to redirect_to phones_path
    end
  end

end
