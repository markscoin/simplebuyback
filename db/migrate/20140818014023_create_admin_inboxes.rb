class CreateAdminInboxes < ActiveRecord::Migration
  def change
    create_table :admin_inboxes do |t|

      t.timestamps
    end
  end
end
