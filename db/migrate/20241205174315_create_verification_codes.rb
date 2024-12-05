class CreateVerificationCodes < ActiveRecord::Migration[7.2]
  def change
    create_table :verification_codes, id: :uuid do |t|
      t.string :code
      t.timestamp :expires_at
      t.string :target

      t.timestamps
    end
  end
end
