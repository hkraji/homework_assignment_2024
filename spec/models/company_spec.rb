require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'current_deals_amount' do
    let(:company) { create(:company) }

    it 'updates current_deals_amount when a deal is added' do
      deal1 = create(:deal, company: company, amount: 5000)
      deal2 = create(:deal, company: company, amount: 10000)

      expect(company.current_deals_amount).to eq(15000)
    end

    it 'updates current_deals_amount when a deal amount is updated' do
      deal = create(:deal, company: company, amount: 5000)
      expect(company.current_deals_amount).to eq(5000)

      deal.update(amount: 10000)
      expect(company.reload.current_deals_amount).to eq(10000)
    end

    it 'updates current_deals_amount when a deal is removed' do
      deal1 = create(:deal, company: company, amount: 5000)
      deal2 = create(:deal, company: company, amount: 10000)

      expect(company.current_deals_amount).to eq(15000)

      deal1.destroy
      expect(company.reload.current_deals_amount).to eq(10000)
    end
  end
end
