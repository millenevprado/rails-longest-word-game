require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    letters_list = ('A'..'Z').to_a
    @letters = letters_list.sample(10)
  end


  def score
    @user_answer = params['word']
    @all_letters = params['all_letters'].split
    if @user_answer.chars.all? { |char| @user_answer.count(char) <= @all_letters.count(char) }
      if english_word?(@user_answer)
        @message = "Congratulations! #{@user_answer} is a valid English word!"
      else
      @message = "Sorry but #{@user_answer} does not seem to be a valid English word!"
      end
    else
      @message = "Sorry but #{@user_answer} can't be built out of #{@all_letters.join(',')}"
    end

  end

  private

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
