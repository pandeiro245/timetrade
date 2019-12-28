class WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])
    @person = Person.new
  end

  def create
    word = Word.find_or_create_by(
      name: word_params[:name],
      user_id: @current_user.id
    )
    if params[:person_id].present?
      person = Person.find(word_params[:person_id])
      WordPerson.find_or_create_by(
        word: word,
        person: person
      )
      redirect_to person_path(person), notice: 'word was created.'
    end
    redirect_to user_path(@current_user), notice: 'word was created.'
  end

  private
    def word_params
      params.require(:word).permit(:name, :person_id)
    end
end
