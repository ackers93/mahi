class GoalStepsController < ApplicationController
  before_action :authenticate_trainee!
  before_action :set_goal_step, only: %i[ show edit update destroy ]

  # GET /goal_steps or /goal_steps.json
  def index
    @goal_steps = GoalStep.all
  end

  # GET /goal_steps/1 or /goal_steps/1.json
  def show
  end

  # GET /goal_steps/new
  def new
    @goal_step = GoalStep.new
  end

  # GET /goal_steps/1/edit
  def edit
  end

  # POST /goal_steps or /goal_steps.json
  def create
    @goal_step = GoalStep.new(goal_step_params)

    respond_to do |format|
      if @goal_step.save
        format.html { redirect_to @goal_step, notice: "Goal step was successfully created." }
        format.json { render :show, status: :created, location: @goal_step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @goal_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goal_steps/1 or /goal_steps/1.json
  def update
    respond_to do |format|
      if @goal_step.update(goal_step_params)
        format.html { redirect_to @goal_step, notice: "Goal step was successfully updated." }
        format.json { render :show, status: :ok, location: @goal_step }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @goal_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goal_steps/1 or /goal_steps/1.json
  def destroy
    @goal_step.destroy
    respond_to do |format|
      format.html { redirect_to goal_steps_url, notice: "Goal step was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal_step
      @goal_step = GoalStep.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def goal_step_params
      params.require(:goal_step).permit(:name, :goal_steps_date, :goal_id)
    end
end
