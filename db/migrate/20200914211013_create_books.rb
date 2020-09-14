class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.string :thumbnail
      t.string :isbn
      t.string :category

      t.timestamps
    end
  end
end
