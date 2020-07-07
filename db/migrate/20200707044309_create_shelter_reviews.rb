class CreateShelterReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :shelter_reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :picture
      t.references :shelter_id, foreign_key: true
    end
  end
end
