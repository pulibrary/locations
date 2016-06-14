class AddLibraryToFloors < ActiveRecord::Migration
  def change
    add_reference :floors, :library, index: true, foreign_key: true
  end
end
