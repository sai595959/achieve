class AddOmniauthColumnsToUsers < ActiveRecord::Migration
  def change
    # null: false,default: ""
    # ”未入力を許さない”NOT NULL制約と"未入力時は空として扱う"デフォルト値を設定
    add_column :users, :uid, :string, null: false, default: ""
    add_column :users, :provider, :string, null: false, default: ""
    add_column :users, :image_url, :string

    # ユニーク制約（uidとproviderにインデックスを設定して、同じものは複数存在不可能にしている
    add_index :users, [:uid, :provider], unique: true
    # インデックスとは…対象のカラムのデータを取り出し、高速に検索できるように手を加えて保存しておいたもの
    # 普通（？）はid順に上から検索していくが、カラムにインデックスを降ってお行けば、
    # そのカラムを、例えば名前順になるように保存しておくことで、検索しやすくしている

  end
end
