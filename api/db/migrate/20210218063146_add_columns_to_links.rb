class AddColumnsToLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :og_title, :string
    add_column :links, :og_image, :text
    add_column :links, :og_description, :string
    add_column :links, :og_url, :string
  end
end
