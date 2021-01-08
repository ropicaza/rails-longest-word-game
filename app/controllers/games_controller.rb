require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...8).map { ('A'..'Z').to_a[rand(26)]}
  end

  def score
    @result = check_word(params[:word].split)
    @letters = (params[:word] || "").upcase
    @included = included?(@word, @letters)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    (params[:word]).include?(params[:letter])
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dire = open(url).read
    json = JSON.parse(dire)
    json['found']
    # json['length']
  end
end
