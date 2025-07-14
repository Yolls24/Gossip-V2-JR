class User < ApplicationRecord; end
class City < ApplicationRecord; end


class AddCityToUsersAndFixNull < ActiveRecord::Migration[6.1]
  def up
    add_reference :users, :city, null: true, foreign_key: true

    # Pour remplir la colonne city_id, on doit charger le modèle User ici :
    User.reset_column_information
    default_city = City.first

    User.where(city_id: nil).find_each do |user|
      user.update_column(:city_id, default_city.id) if default_city
    end

    change_column_null :users, :city_id, false
  end

  def down
    remove_reference :users, :city, foreign_key: true
  end
end

