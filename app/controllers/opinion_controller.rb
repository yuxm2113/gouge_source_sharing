class OpinionController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @opinion_pages, @opinions = paginate :opinions, :per_page => 10
  end

  def show
    @opinion = Opinion.find(params[:id])
  end

  def new
    @opinion = Opinion.new
  end

  def create
    @opinion = Opinion.new(params[:opinion])
    @opinion.content=@opinion.content.gsub(/\r\n/,"<br/>")
    if @opinion.save
      flash[:notice] = 'Opinion was successfully created.'
      uri=session[:original_uri] 
      redirect_to(uri || {:action => 'list'})
    else
      render :action => 'new'
    end
  end

  def edit
    @opinion = Opinion.find(params[:id])
  end

  def update
    @opinion = Opinion.find(params[:id])
    if @opinion.update_attributes(params[:opinion])
      flash[:notice] = 'Opinion was successfully updated.'
      redirect_to :action => 'show', :id => @opinion
    else
      render :action => 'edit'
    end
  end

  def destroy
    Opinion.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
