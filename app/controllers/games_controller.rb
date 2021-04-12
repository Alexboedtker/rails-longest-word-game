class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @score = nil

    if included?(@word.upcase, @letters)
      if english_word?(@word)
        @score = "Congratulations! ${word} is a valid English word!"
      else
        @score = "Sorry but ${@word} does not seem to be a valid English word..."
      end
    else
      @score = "Sorry but ${@word} can't be built out of ${@letters}"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(attempt, grid)
    aattempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end
end
