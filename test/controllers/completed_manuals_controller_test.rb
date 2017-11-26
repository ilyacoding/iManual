require 'test_helper'

class CompletedManualsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @completed_manual = completed_manuals(:one)
  end

  test "should get index" do
    get completed_manuals_url
    assert_response :success
  end

  test "should get new" do
    get new_completed_manual_url
    assert_response :success
  end

  test "should create completed_manual" do
    assert_difference('CompletedManual.count') do
      post completed_manuals_url, params: { completed_manual: { manual_id: @completed_manual.manual_id, user_id: @completed_manual.user_id } }
    end

    assert_redirected_to completed_manual_url(CompletedManual.last)
  end

  test "should show completed_manual" do
    get completed_manual_url(@completed_manual)
    assert_response :success
  end

  test "should get edit" do
    get edit_completed_manual_url(@completed_manual)
    assert_response :success
  end

  test "should update completed_manual" do
    patch completed_manual_url(@completed_manual), params: { completed_manual: { manual_id: @completed_manual.manual_id, user_id: @completed_manual.user_id } }
    assert_redirected_to completed_manual_url(@completed_manual)
  end

  test "should destroy completed_manual" do
    assert_difference('CompletedManual.count', -1) do
      delete completed_manual_url(@completed_manual)
    end

    assert_redirected_to completed_manuals_url
  end
end
