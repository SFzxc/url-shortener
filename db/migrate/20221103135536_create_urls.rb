class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls, id: :bigserial do |t|
      t.string :short_url, null: false, index: { unique: true }
      t.string :original_url, null: false
      t.datetime :expired_at, index: true
      t.timestamps
    end
  end
end
