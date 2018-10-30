# frozen_string_literal: true

class KindsController < ApplicationController

  TOKEN = "secret123"

  include ActionController::HttpAuthentication::Token::ControllerMethods

  #include ActionController::HttpAuthentication::Basic::ControllerMethods
  # http_basic_authenticate_with name: "admin", password: "secret#123"

  #include ActionController::HttpAuthentication::Digest::ControllerMethods
  #USERS = { "admin" => Digest::MD5::hexdigest(["admin", "Application", "secret#123"].join(":"))}

  #before_action :authenticate

  before_action :authenticate_with_token
  before_action :set_kind, only: %i[show update destroy]

  # GET /kinds
  def index
    @kinds = Kind.all

    render json: @kinds
  end

  # GET /kinds/1
  def show
    render json: @kind
  end

  # POST /kinds
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      render json: @kind, status: :created, location: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kinds/1
  def update
    if @kind.update(kind_params)
      render json: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kinds/1
  def destroy
    @kind.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_kind
    if params[:contact_id]
      @kind = Contact.find(params[:contact_id]).kind
      return @kind
    end
    @kind = Kind.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def kind_params
    params.require(:kind).permit(:Kind, :description)
  end

  def authenticate
    authenticate_or_request_with_http_digest("Application") do |username|
      USERS[username]
    end
  end

  def authenticate_with_token
    authenticate_or_request_with_http_token do |token, options|
      # ActiveSupport::SecurityUtils.secure_compare(
      #   ::Digest::SHA256.hexdigest(token),
      #   ::Digest::SHA256.hexdigest(TOKEN)
      # )
      hmac_secret = 'my$ecretK3y'
      JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
    end
  end
end
