require "test_helper"

class GoalStepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goal_step = goal_steps(:one)
  end

  test "should get index" do
    get goal_steps_url
    assert_response :success
  end

  test "should get new" do
    get new_goal_step_url
    assert_response :success
  end

  test "should create goal_step" do
    assert_difference('GoalStep.count') do
      post goal_steps_url, params: { goal_step: { goal_id: @goal_step.goal_id, goal_steps_date: @goal_step.goal_steps_date, name: @goal_step.name } }
    end

    assert_redirected_to goal_step_url(GoalStep.last)
  end

  test "should show goal_step" do
    get goal_step_url(@goal_step)
    assert_response :success
  end

  test "should get edit" do
    get edit_goal_step_url(@goal_step)
    assert_response :success
  end

  test "should update goal_step" do
    patch goal_step_url(@goal_step), params: { goal_step: { goal_id: @goal_step.goal_id, goal_steps_date: @goal_step.goal_steps_date, name: @goal_step.name } }
    assert_redirected_to goal_step_url(@goal_step)
  end

  test "should destroy goal_step" do
    assert_difference('GoalStep.count', -1) do
      delete goal_step_url(@goal_step)
    end

    assert_redirected_to goal_steps_url
  end
end
