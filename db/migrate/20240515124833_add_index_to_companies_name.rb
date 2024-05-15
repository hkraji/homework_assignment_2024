class AddIndexToCompaniesName < ActiveRecord::Migration[7.0]
  def change
    add_index :companies, :name
  end
end
