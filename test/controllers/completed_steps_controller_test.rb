require 'test_helper'

class CompletedStepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @completed_step = completed_steps(:one)
  end

  test "should get index" do
    get completed_steps_url
    assert_response :success
  end

  test "should get new" do
    get new_completed_step_url
    assert_response :success
  end

  test "should create completed_step" do
    assert_difference('CompletedStep.count') do
      post completed_steps_url, params: { completed_step: { completed_manual_id: @completed_step.completed_manual_id, step_id: @completed_step.step_id, user_id: @completed_step.user_id } }
    end

    assert_redirected_to completed_step_url(CompletedStep.last)
  end

  test "should show completed_step" do
    get completed_step_url(@completed_step)
    assert_response :success
  end

  test "should get edit" do
    get edit_completed_step_url(@completed_step)
    assert_response :success
  end

  test "should update completed_step" do
    patch completed_step_url(@completed_step), params: { completed_step: { completed_manual_id: @completed_step.completed_manual_id, step_id: @completed_step.step_id, user_id: @completed_step.user_id } }
    assert_redirected_to completed_step_url(@completed_step)
  end

  test "should destroy completed_step" do
    assert_difference('CompletedStep.count', -1) do
      delete completed_step_url(@completed_step)
    end

    assert_redirected_to completed_steps_url
  end
end
