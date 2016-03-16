class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    %w(home office mobile).each do |phone|
      @contact.phones.build(phone_type: phone)
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contact_path(@contact)
    else
      render :new
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to contact_path(@contact)
    else
      render :edit
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name)
  end
end
