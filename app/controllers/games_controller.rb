require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @word = params[:word]
    @rand_letters = JSON.parse(params[:letters])
    if (@word.chars.all? { |letter| @word.chars.count(letter) <= @rand_letters.count(letter.upcase) }) && english_word?(@word)
      @result = "Congratulations, #{@word.upcase} is a valid English word!"
    elsif (@word.chars.all? { |letter| @word.chars.count(letter) <= @rand_letters.count(letter.upcase) }) && !english_word?(@word)
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @result = "Sorry #{@word.upcase} can't be built from #{@rand_letters}."
    end
  end
end
