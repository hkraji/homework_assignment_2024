require 'factory_bot_rails'

namespace :seed do
  desc "Seed the database with a number of companies and deals. Options: (COMPANIES=1000 DEALS_PER_COMPANY=5)"
  task companies: :environment do
    num_companies = (ENV['COMPANIES'] || 1000).to_i
    deals_per_company = (ENV['DEALS_PER_COMPANY'] || 5).to_i

    industries = Industry.all

    puts "-----------------------------------------"
    num_companies.times do |i|
      company = FactoryBot.create(:company, industry: industries.sample)
      FactoryBot.create_list(:deal, deals_per_company, company: company)

      if ((i + 1) % (num_companies / 10) == 0)
        percentage = ((i + 1) * 100) / num_companies
        puts "#{percentage.to_s.rjust(3)}% of companies created."
      end
    end

    puts "-----------------------------------------"
    puts "#{num_companies} companies with #{deals_per_company} deals each created."
  end
end
