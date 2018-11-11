module V1
  class PhonesController < ApplicationController
    before_action :set_contact

    # GET /contacts/1/phones
    def show
      render json: @contact.phones
    end

    # POST /contact/1/phones
    def create
      @contact.phones << Phone.new(phone_params)

      if @contact.save
        render json: @contact.phones, status: :created, location: contact_phones_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    def update
      phone = Phone.find(phone_params[:id])

      if phone.update(phone_params)
        render json: @contact.phones
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    def destroy
      phone = Phone.find(phone_params[:id])
      phone.destroy
    end

    private

    def set_contact
      @contact = Contact.find(params[:contact_id])
    end

    def phone_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
  end
end
