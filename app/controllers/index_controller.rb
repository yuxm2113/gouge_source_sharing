class IndexController < ApplicationController
  layout "index"
  def index
     @signs =Sign.find(:all,:order=>'id DESC',:limit=>40)
  end
end
