require 'pry-byebug'

dictionary = File.readlines('google-10000-english-no-swears.txt')
word = dictionary[rand(dictionary.length - 1)].chomp until word.to_s.length > 4 && word.to_s.length < 13
display_word = []
word.length.times { display_word.push('_') }
wrong_letters = []
turns_remaining = 7

while turns_remaining.positive?
  puts "Please choose a letter. You have #{turns_remaining} wrong guesses remaining."
  p display_word
  puts "There is no #{wrong_letters}" if wrong_letters.length.positive?
  choice = gets.chomp.downcase

  if word.include?(choice)
    choice_index = word.index(choice)
    display_word[choice_index] = word[choice_index]
  else
    puts "There is no #{choice} in this word"
    wrong_letters.push(choice)
    turns_remaining -= 1
  end

  if display_word.join == word
    puts "You win! The word was #{word}."
  end
end

unless turns_remaining.positive?
  puts "You lost :( The word was #{word}."
end
