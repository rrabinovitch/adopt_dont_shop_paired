class CreatePetAdoptionApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :pet_adoption_applications do |t|
      t.references :pet, foreign_key: true
      t.references :adoption_application, foreign_key: true

      t.timestamps
    end
  end
end
