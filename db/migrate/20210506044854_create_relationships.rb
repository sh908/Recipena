class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id #フォローするユーザのid
      t.integer :followed_id #フォローされるユーザのid

      t.timestamps
    end
  end
end
