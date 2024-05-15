class Api::V1::IndustriesController < ApplicationController
  def index
    render json: Industry.select(:id, :name).as_json
  end
end
