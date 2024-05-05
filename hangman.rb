require 'pry-byebug'
require 'yaml'

# play a game of Hangman in the terminal
class Hangman
  DICTIONARY = File.readlines('google-10000-english-no-swears.txt')
  attr_accessor :word, :display_word, :turns_remaining

  def initialize
    @word = DICTIONARY[rand(DICTIONARY.length - 1)].chomp until word.to_s.length > 4 && word.to_s.length < 13
    @display_word = []
    word.length.times { display_word.push('_') }
    @wrong_letters = []
    @turns_remaining = 7
  end

  def play
    while turns_remaining.positive?
      puts "Please choose a letter. You have #{turns_remaining} wrong guesses remaining."
      p display_word
      puts "There is no #{@wrong_letters}" if @wrong_letters.length.positive?
      choice = gets.chomp.downcase

      if word.include?(choice)
        choice_index = word.index(choice)
        display_word[choice_index] = word[choice_index]
      else
        puts "There is no #{choice} in this word"
        @wrong_letters.push(choice)
        @turns_remaining -= 1
      end

      puts "You win! The word was #{word}." if display_word.join == word

      puts 'Would you like to save your game? y/n'
      do_save = gets.chomp.downcase
      save_game if do_save == 'y'
    end

    puts "You lost :( The word was #{word}." unless turns_remaining.positive?
  end

  def save_game
    f = File.open('hangman_save', 'w+')
    f.puts YAML.dump(self)
    f.close
  end
end

def load_game(game)
  YAML.unsafe_load(File.read(game))
end
