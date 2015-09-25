class Modifyrelationships < ActiveRecord::Migration
  def change
  	add_column("relationships","Status",:text,:limit=>10)
  end
end
