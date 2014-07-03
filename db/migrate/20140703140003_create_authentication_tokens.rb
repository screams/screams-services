class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.string :authentication_token
      t.boolean :expires, :default => false
      t.datetime :expires_at, :default => DateTime.now
      t.references :user

      t.timestamps
    end
  end
end
