class AddCurrentDealsAmountToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :current_deals_amount, :decimal
    add_index :companies, :current_deals_amount

    say_with_time 'Updating current_deals_amount for companies' do
      Company.find_each do |company|
        company.calculate_and_update_deals_amount!
      end
    end
  end
end
