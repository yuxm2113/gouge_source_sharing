class Sign < ActiveRecord::Base
  has_many :opinions
  validates_format_of :src,
    :with=>/^.*(.jpg|.JPG|.GIF|.gif|.png|.PNG|.mp3|.MP3|.avi|.AVI)$/,
    :message =>"上传的文件格式无效"
  file_column :src,:magick =>{
    :versions=>{"thumb"=>"60x60","medium"=>"200x200"}
  }

  
  def  before_save
    self.user_id=current_user.id
  end
end

=begin
    #������ű�
    create_table "signs"  do |t|
	t.column :user_id,	:integer
	t.column :type,		:integer  #����,1����,2ͼ��,3��Ƶ,4��Ƶ
	t.column :tags,		:string,:limit=>100
	t.column :src,		:string
	t.column :desc,		:text,	 :limit=>2000
    end
=end