class AddStatusToAdoptionApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :adoption_applications, :status, :string
  end
end
