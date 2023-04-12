class CreateDelegateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :delegate_users do |t|
      t.references :primary_user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :access_code

      t.timestamps
    end
  end
end
