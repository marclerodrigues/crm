require 'spec_helper'
require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  describe "GET #index" do
    it "populates and array of contacts" do
      contact = FactoryGirl.create(:contact)
      get :index
      expect(assigns(:contacts)).to eq([contact])
    end
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested contact to @contact" do
      contact = FactoryGirl.create(:contact)
      get :show, id: contact
      expect(assigns(:contact)).to eq(contact)
    end
    it "renders the :show template" do
      get :show, id: FactoryGirl.create(:contact)
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a home, office, and mobile phone to the new contact" do
      get :new
      expect(assigns(:contact).phones.map{ |p| p.phone_type}).to eq %w(home office mobile)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new contact" do
        expect {
          post :create, contact: FactoryGirl.attributes_for(:contact)
        }.to change(Contact, :count).by(1)
      end
      it "redirects to new contact" do
        post :create, contact: FactoryGirl.attributes_for(:contact)
        expect(response).to redirect_to Contact.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect {
          post :create, contact: FactoryGirl.attributes_for(:invalid_contact)
        }.to_not change(Contact, :count)
      end

      it "re-renders the :new template" do
        post :create, contact: FactoryGirl.attributes_for(:invalid_contact)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    before :each do
      @contact = FactoryGirl.create(:contact, first_name: "Lawrence", last_name: "Smith")
    end

    context "valid attributes" do
      it "located the request @contact" do
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:contact)
        expect(assigns(:contact)).to eq(@contact)
      end

      it "changes @contact's attributes" do
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:contact, first_name:"Larry", last_name: "Smith")
        @contact.reload
        expect( [@contact.first_name, @contact.last_name] ).to eq(["Larry", "Smith"])
      end

      it "redirects to the updated contact" do
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:contact)
        expect(response).to redirect_to @contact
      end
    end

    context "invalid attributes" do
      it "locates the requested @contact" do
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:invalid_contact)
        expect(assigns(:contact)).to eq(@contact)
      end

      it "does not change @@contact's attributes" do
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:invalid_contact, first_name:"Larry", last_name: nil)
        @contact.reload
        expect(@contact.first_name).not_to eq("Larry")
        expect(@contact.last_name).to eq("Smith")
      end

      it "re-renders the edit method" do
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:invalid_contact)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @contact = FactoryGirl.create(:contact)
    end

    it "deletes the contact" do
      expect{
        delete :destroy, id: @contact
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to contact#index" do
      delete :destroy, id: @contact
      expect(response).to redirect_to contacts_path
    end
  end
end
