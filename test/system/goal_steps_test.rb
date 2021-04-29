require "application_system_test_case"

class GoalStepsTest < ApplicationSystemTestCase
  setup do
    @goal_step = goal_steps(:one)
  end

  test "visiting the index" do
    visit goal_steps_url
    assert_selector "h1", text: "Goal Steps"
  end

  test "creating a Goal step" do
    visit goal_steps_url
    click_on "New Goal Step"

    fill_in "Goal", with: @goal_step.goal_id
    fill_in "Goal steps date", with: @goal_step.goal_steps_date
    fill_in "Name", with: @goal_step.name
    click_on "Create Goal step"

    assert_text "Goal step was successfully created"
    click_on "Back"
  end

  test "updating a Goal step" do
    visit goal_steps_url
    click_on "Edit", match: :first

    fill_in "Goal", with: @goal_step.goal_id
    fill_in "Goal steps date", with: @goal_step.goal_steps_date
    fill_in "Name", with: @goal_step.name
    click_on "Update Goal step"

    assert_text "Goal step was successfully updated"
    click_on "Back"
  end

  test "destroying a Goal step" do
    visit goal_steps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Goal step was successfully destroyed"
  end
end
