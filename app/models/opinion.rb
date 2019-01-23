class Opinion < ActiveRecord::Base
	belongs_to :sign

	def  before_save
		self.user_id=current_user.id
	end
end

=begin
    #创建评价表
    create_table "opinions" do |t|
	t.column :user_id,	:integer
	t.column :sign_id,	:integer
	t.column :type,		:integer
	t.column :content,	:text,	 :limit=>2000
	t.column :created_at,	 :datetime
    end
=end