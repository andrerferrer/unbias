class CreateComparisons < ActiveRecord::Migration[6.0]
  def change
    create_table :comparisons do |t|
      t.string :topic
      t.date :start_date
      t.date :end_date
      t.string :country_one
      t.string :country_two
      t.string :publisher_one
      t.string :publisher_two
      t.string :api_error
      t.string :comparison_name
      t.string :comparison_desription
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
