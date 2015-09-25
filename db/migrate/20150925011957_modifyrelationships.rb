class Modifyrelationships < ActiveRecord::Migration
  def change
  	add_column("relationships","Status",:string,:limit=>10)
  end
end
