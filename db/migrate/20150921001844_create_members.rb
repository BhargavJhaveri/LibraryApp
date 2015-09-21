class CreateMembers < ActiveRecord::Migration
  def up
    create_table :members do |t|

      t.string 'email', unique: true
      t.string 'first_name', limit: 50
      t.string 'last_name', limit: 50
      t.string 'password', null: false

      t.timestamps
    end
  end

  def down
    drop_table :members
  end
end
