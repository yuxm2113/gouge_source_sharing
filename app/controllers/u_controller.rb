class UController < ApplicationController
  layout "u_index"
  def index
    show 
    render :action=>"show"
  end
  @u=nil
  def init_user
    #find page user
    if params[:id] !=nil
      @u=User.find_by_login(params[:id])
    elsif session[:user] !=nil
      @u=User.find(session[:user])
    else
      @u=User.find(:first,:order=>'id DESC')
    end
  end
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
    :redirect_to => { :action => :list }

  def list
    init_user
  end

  def show
    init_user
    #find page user's info
     @sign_pages, @signs = paginate :signs, :per_page => 10,:order=>'id DESC',:conditions=>'user_id='+@u.id.to_s
  end
  def edit
    init_user
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:opinion])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
