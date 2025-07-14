class RemoveGossipIdFromLikes < ActiveRecord::Migration[8.0]
  def change
    remove_column :likes, :gossip_id, :integer
  end
end
