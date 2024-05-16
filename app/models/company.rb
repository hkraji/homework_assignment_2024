class Company < ApplicationRecord
  has_many   :deals
  belongs_to :industry

  def calculate_and_update_deals_amount!
    update_columns(current_deals_amount: deals.sum(:amount))
  end
end
