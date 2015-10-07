class Editsubmissions < ActiveRecord::Migration
  def change
  	add_column("suggestions","email",:text)
  end
end
