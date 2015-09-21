class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|

      t.string 'ISBN', unique: true
      t.string 'title'
      t.string 'description'
      t.string 'authors'
      t.string 'status'

      t.timestamps
    end
  end

  def down
    drop_table :books
  end
end
