require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    tmp = true
    word = params[:answer]
    word_arr = word.chars
    word_arr.each do |ltr|
      if params[:letters].include?(ltr)

    end
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    answer_serialized = open(url).read
    @is_world_real = JSON.parse(answer_serialized)['found']
  end
end
