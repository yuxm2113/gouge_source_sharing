require File.dirname(__FILE__) + '/../test_helper'
require 'opinion_controller'

# Re-raise errors caught by the controller.
class OpinionController; def rescue_action(e) raise e end; end

class OpinionControllerTest < Test::Unit::TestCase
  fixtures :opinions

  def setup
    @controller = OpinionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = opinions(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:opinions)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:opinion)
    assert assigns(:opinion).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:opinion)
  end

  def test_create
    num_opinions = Opinion.count

    post :create, :opinion => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_opinions + 1, Opinion.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:opinion)
    assert assigns(:opinion).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Opinion.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Opinion.find(@first_id)
    }
  end
end
