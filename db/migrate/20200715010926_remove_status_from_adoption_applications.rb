class RemoveStatusFromAdoptionApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :adoption_applications, :status, :string
  end
end
