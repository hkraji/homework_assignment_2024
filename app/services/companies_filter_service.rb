class CompaniesFilterService
  #
  # @param  params [Hash] a hash of parameters used for filtering companies
  # @option params [String] :name (optional) a partial string of company name
  # @option params [String] :industries (optional) a comma-separated list of industry IDs
  # @option params [String] :employee_count (optional) the minimum number of employees
  # @option params [String] :deal_amount (optional) the minimum deal amount
  # @option params [String] :limit (optional) return size of the result set
  def initialize(params)
    @params = params
  end

  def call
    companies = Company.all

    if param(:name)
      companies = companies.where('name LIKE ?', "%#{param(:name)}%")
    end

    if param(:industries)
      industry_ids = param(:industries).split(',').map(&:to_i)
      companies = companies.where(industry_id: industry_ids)
    end

    if param(:employee_count)
      companies = companies.where('employee_count >= ?', param(:employee_count).to_i)
    end

    if param(:deal_amount)
      companies = companies.where('current_deals_amount >= ?', param(:deal_amount).to_i)
    end

    if param(:limit)
      companies = companies.limit(param(:limit).to_i)
    end

    companies = companies.includes(:industry).order(created_at: :desc)
  end

  private

  def param(key)
    @params&.fetch(key, nil)
  end
end
