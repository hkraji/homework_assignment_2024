class Deal < ApplicationRecord
  belongs_to :company

  after_commit :update_company_deals_amount

  private

  def update_company_deals_amount
    company.calculate_and_update_deals_amount!
  end
end
