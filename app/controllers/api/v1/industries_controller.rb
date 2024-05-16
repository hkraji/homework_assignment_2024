class Api::V1::IndustriesController < Api::V1::ActionController
  def index
    render json: Industry.select(:id, :name).as_json
  end

end
