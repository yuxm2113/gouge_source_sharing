class SignController < ApplicationController
  before_filter :configure_charsets   
  before_filter :login_required, :only => [ :edit, :update,:new,:create,:delete,:destroy ]
  layout "index"
   def configure_charsets
     @headers["Content-Type"]="text/html;charset=utf-8"
   end
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @sign_pages, @signs = paginate :signs, :per_page => 10
   @signs =Sign.find(:all,:order=>'id DESC',:limit=>150)
  end
  def show
    @sign = Sign.find(params[:id])
    @opinion_pages, @opinions = paginate(:opinions, 
      :conditions =>'sign_id ='+@sign.id.to_s,:order_by => 'id desc', :per_page =>10)
    session[:original_uri] = request.request_uri 
  end

  def new
    @sign = Sign.new
  end

  def create
    @sign = Sign.new(params[:sign])
    @sign.desc=@sign.desc.gsub(/\r\n/, '<br/>')
    if @sign.save
      flash[:notice] = 'Sign was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @sign = Sign.find(params[:id])
  end

  def update
    @sign = Sign.find(params[:id])
    if @sign.update_attributes(params[:sign])
      flash[:notice] = 'Sign was successfully updated.'
      redirect_to :action => 'show', :id => @sign
    else
      render :action => 'edit'
    end
  end

  def destroy
    Sign.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
