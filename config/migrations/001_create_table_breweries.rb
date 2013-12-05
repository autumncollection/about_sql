# encoding : utf-8

Sequel.migration do
  up do
    create_table(:Breweries) do
      primary_key :id
      String :name
      String :address
    end
  end

  down do
    drop_table(:Breweries)
  end
end