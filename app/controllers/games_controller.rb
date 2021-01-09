require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = ["A", "E", "I", "O", "U"]

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letter]
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @check_word = check_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def check_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
    # json['length']
  end
end
