class CreateMsgs < ActiveRecord::Migration[6.1]
  def change
    create_table :msgs do |t|
      t.text :body
      t.references :chat, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
