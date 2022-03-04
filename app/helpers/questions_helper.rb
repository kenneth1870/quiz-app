module QuestionsHelper
  def get_questions_title(sum_questions)
    sum_questions <= 1 ? "Question:" : sum_questions.to_s + " Questions:" 
  end
end
