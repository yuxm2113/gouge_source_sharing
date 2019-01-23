class CreateSigns < ActiveRecord::Migration
  def self.up
    #创建符号表
    create_table "signs"  do |t|
	t.column :user_id,	:integer
	t.column :level,		:integer  #类型,1文字,2图像,3音频,4视频
	t.column :tags,		:string,:limit=>100
	t.column :src,		:string
	t.column :desc,		:text,	 :limit=>2000
    end
    #创建评价表
    create_table "opinions" do |t|
	t.column :user_id,	:integer
	t.column :sign_id,	:integer
	t.column :type,		:integer
	t.column :content,	:text,	 :limit=>2000
	t.column :created_at,	 :datetime
    end
  end

  def self.down
    drop_table "signs"
    drop_table "opinions"
  end
end
