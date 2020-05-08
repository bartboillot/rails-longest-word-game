require 'json'
require 'open-uri'

# Games Controller
class GamesController < ApplicationController
  def new
    session[:score] = 0 unless session[:score]
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    set_of_letters = params[:letters].upcase.gsub('"', '')
    set_of_letters = set_of_letters.gsub('[', '').gsub(']', '').split(', ')
    word = params[:answer].upcase
    @increment = 0
    if word_in_set?(word, set_of_letters) && valid_english?(word)
      @increment = word.length
      session[:score] += @increment
      @result = "Congratulation! <strong>#{word}</strong> is a valid english word!"
    elsif word_in_set?(word, set_of_letters)
      @result = "Sorry but <strong>#{word}</strong>, does not seem to be a valid English word"
    else
      @result = "Sorry but <strong>#{word}</strong>, can't be built out of #{set_of_letters.join(', ')}"
    end
  end

  private

  def word_in_set?(word, set_of_letters)
    copy_set = set_of_letters.map(&:clone)
    word_arr = word.chars
    word_arr.each do |ltr|
      return false unless copy_set.include?(ltr)

      copy_set.delete_at(copy_set.find_index(ltr))
    end
    # true
  end

  def valid_english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    answer_serialized = open(url).read
    JSON.parse(answer_serialized)['found']
  end
end
