class RenameBodyToContentInMessages < ActiveRecord::Migration[8.0]
  def change
    rename_column :messages, :body, :content
  end
end

