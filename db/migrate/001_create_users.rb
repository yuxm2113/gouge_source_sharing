class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :location, :string #µØÖ·
      t.column :image_url,:string,:default=>'images/song.png' #Ğ¤Ïñ
      t.column :about_me, :text,:limit=>800   #×ÔÎÒÃèÊö
    end
  end

  def self.down
    drop_table "users"
  end
end
