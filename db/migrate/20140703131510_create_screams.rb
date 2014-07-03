class CreateScreams < ActiveRecord::Migration
  def change
    create_table :screams do |t|
      t.text :text
      t.boolean :private_scream, :default => false
      t.references :user

      t.timestamps
    end
  end
end
