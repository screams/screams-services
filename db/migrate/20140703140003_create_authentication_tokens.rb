class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.string :token
      t.boolean :expires, :default => false
      t.datetime :generated_at, :default => DateTime.now
      t.references :user

      t.timestamps
    end
  end
end
