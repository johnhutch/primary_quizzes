class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.order("elo DESC").limit(10)
    @users = User.all.order("elo DESC").limit(10)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show

  end

  # GET /questions/random
  def random
    # Retrieves a random question from the database
    if(user_signed_in?)
      low_adjusted_elo = current_user.elo - 200
      high_adjusted_elo = current_user.elo + 200
      @all_questions = Question.where("user_id != '#{current_user.id}' AND elo >= #{low_adjusted_elo} AND elo <= #{high_adjusted_elo}").order("RANDOM()")
      @all_questions.each do |q|
        unless current_user.answers.include?(q)
          @question = q
          break
        end
      end
    else
      @question = Question.order("RANDOM()").first
    end
  end

  # GET /questions/1/solve/1
  def solve
    if(user_signed_in?)
      @question = Question.find(params[:id])
      @choice = Choice.find(params[:choice_id])
      current_user.answers.build(:question_id => @question.id)
      current_user.save!

      if @question.check_for_solution(current_user, @choice)
        redirect_to random_question_path, notice: "Correctamundo! Well done! Cheers! and all that."
      else
        redirect_to random_question_path, alert: "Whomp whoooomp, that was the wrong answer."
      end
    else
      redirect_to random_question_path, notice: "Sign up to find out if you're right."
    end
  end

  # GET /questions/new
  def new
    # Initiate question, added to current_user
    @question = current_user.questions.build

    # Create four choices
    4.times { @question.choices.build }
    #@choices = @question.choices

    # Get all categories for form
    @categories = Category.all
  end

  # GET /questions/1/edit
  def edit
    #@question = Question.find_by_id(:id)
    #@choices = @question.choices
    @categories = Category.all
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    current_user.elo = current_user.elo + rand(3) + 1
    current_user.save!

    respond_to do |format|
      if @question.save
        # Couldn't use solution from params because the choice isn't saved yet, so it has no id
        # That's why this logic is in here, though it seems real bad
        # Could redirect to a set_solution method in this controller maybe?
        @question.solution_id = @question.choices.first.id
        @question.save

        format.html { redirect_to root_path, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        # Couldn't use solution from params because the choice isn't saved yet, so it has no id
        # That's why this logic is in here, though it seems real bad
        # Could redirect to a set_solution method in this controller maybe?
        @question.solution_id = @question.choices.first.id
        @question.save

        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:body, :solution_id, :category_id, :user_id, :elo, choices_attributes: [:body])
    end
end
