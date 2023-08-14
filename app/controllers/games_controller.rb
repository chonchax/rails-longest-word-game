require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0..10).map { ('a'..'z').to_a.sample }
  end

  def score
    @word = params[:word].downcase
    @include = exist?(@word)
    @letters = params[:letters].split
    @included = included?(@word, @letters)
  end

  private

  def exist?(word)
    file = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(file.read)
    json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
