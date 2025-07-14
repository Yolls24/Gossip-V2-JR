# db/migrate/XXXXXX_create_users.rb
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :description
      t.string :email
      t.string :password_digest
      t.belongs_to :city, index: true

      t.timestamps
    end
  end
end
