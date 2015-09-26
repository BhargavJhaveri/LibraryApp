class Modifyrelationships < ActiveRecord::Migration
  def change
  	add_column("relationships","status",:text,:limit=>10)
  end
end
