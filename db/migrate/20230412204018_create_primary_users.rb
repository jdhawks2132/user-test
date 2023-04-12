class CreatePrimaryUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :primary_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :is_primary
      t.string :access_code
      t.string :unique_url_hash

      t.timestamps
    end
  end
end
