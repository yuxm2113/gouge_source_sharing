require File.dirname(__FILE__) + '/../test_helper'
require 'sign_controller'

# Re-raise errors caught by the controller.
class SignController; def rescue_action(e) raise e end; end

class SignControllerTest < Test::Unit::TestCase
  fixtures :signs

  def setup
    @controller = SignController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = signs(:first).id
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

    assert_not_nil assigns(:signs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:sign)
    assert assigns(:sign).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:sign)
  end

  def test_create
    num_signs = Sign.count

    post :create, :sign => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_signs + 1, Sign.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:sign)
    assert assigns(:sign).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Sign.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Sign.find(@first_id)
    }
  end
end
