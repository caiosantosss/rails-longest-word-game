class GamesController < ApplicationController

  def new
    @letters = new_array
  end

  def score
    @english_word = get_words(params[:user_word])
    @included = in_the_letters(params[:user_word])
    @result = @english_word && @included ? 'Good Job 😎' : 'Nahh, try again 😐'
  end

  require 'open-uri'

  def get_words(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    data = URI.open(url).read
    @words = JSON.parse(data)
    return @words['found']
  end

  def in_the_letters(user_word)
    @letters = params[:letters]
    @word = params[:user_word]
    user_word.split('').all? do |letter|
      @letters.count(letter) >= @word.count(letter)
    end
    return true
  end

  def new_array
    array = []
    10.times { array << ('A'..'Z').to_a.sample }
    return array
  end
end
