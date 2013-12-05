# encoding : utf-8

Sequel.migration do
  up do
    create_table(:Brands) do
      primary_key :id
      foreign_key :brewery_id, :Breweries, key: :id
      String :name
      String :voltage
    end
  end

  down do
    drop_table(:Brands)
  end
end