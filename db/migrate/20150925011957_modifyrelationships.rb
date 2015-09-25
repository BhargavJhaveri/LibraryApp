class Modifyrelationships < ActiveRecord::Migration
  def change
  	add_column("Relationships","Status",:string,:limit=>10)
  end
end
