require 'rails_helper'

RSpec.describe CompaniesFilterService do
  let!(:industry1) { create(:industry) }
  let!(:industry2) { create(:industry) }
  let!(:company1) { create(:company, name: "Alpha Company", industry: industry1, employee_count: 50, current_deals_amount: 5000) }
  let!(:company2) { create(:company, name: "Beta Company", industry: industry2, employee_count: 150, current_deals_amount: 15000) }
  let!(:company3) { create(:company, name: "Gamma Company", industry: industry1, employee_count: 200, current_deals_amount: 25000) }

  describe "#call" do
    context "when filtering by name" do
      it "returns companies with matching names" do
        service = CompaniesFilterService.new(name: "Alpha")
        result = service.call
        expect(result).to match_array([company1])
      end
    end

    context "when filtering by industries" do
      it "returns companies belonging to industries" do
        service = CompaniesFilterService.new(industries: "#{industry1.id},#{industry2.id}")
        result = service.call
        expect(result).to match_array([company1, company2, company3])
      end

      it "returns companies belonging to a single specified industry" do
        service = CompaniesFilterService.new(industries: "#{industry1.id}")
        result = service.call
        expect(result).to match_array([company1, company3])
      end
    end

    context "when filtering by employee count" do
      it "returns companies with at least given number of employees" do
        service = CompaniesFilterService.new(employee_count: "100")
        result = service.call
        expect(result).to match_array([company2, company3])
      end
    end

    context "when filtering by deal amount" do
      it "returns companies with at least given deal amount" do
        service = CompaniesFilterService.new(deal_amount: "10000")
        result = service.call
        expect(result).to match_array([company2, company3])
      end
    end

    context "when limiting the number of results" do
      it "returns the specified number of companies" do
        service = CompaniesFilterService.new(limit: "1")
        result = service.call
        expect(result.size).to eq(1)
      end
    end

    context "when combining multiple filters" do
      it "returns companies matching all filters" do
        service = CompaniesFilterService.new(name: "Company", industries: "#{industry1.id}", employee_count: "150", deal_amount: "20000")
        result = service.call
        expect(result).to match_array([company3])
      end
    end
  end
end
