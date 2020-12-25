class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    # usersテーブルにadminという型booleanの属性をデフォルトfalseで追加
    add_column :users, :admin, :boolean, default:false
  end
end
