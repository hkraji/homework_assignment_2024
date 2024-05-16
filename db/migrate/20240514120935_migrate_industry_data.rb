class MigrateIndustryData < ActiveRecord::Migration[7.0]
  def up
    add_column :companies, :industry_id, :integer

    # usually I would avoid doing data migrations inside db migrations but in this case it seems prudent
    # due to posibble syncing issues between schema and data change

    industry_names = Company.pluck(:industry).uniq
    industry_names.map { |industry_name| Industry.create(name: industry_name) }

    say_with_time 'Updating industry_id for companies' do
      Company.find_each do |company|
        industry_id = Industry.find_by(name: company.attributes['industry']).id
        company.update(industry_id: industry_id)
      end
    end

    remove_column :companies, :industry
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
