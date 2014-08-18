class CreateEmailProcessors < ActiveRecord::Migration
  def change
    create_table :email_processors, :force => true do |t|
      t.string "email"
      t.text   "body"
      t.timestamps
    end
  end
end
