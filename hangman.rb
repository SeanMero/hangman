dictionary = File.readlines('google-10000-english-no-swears.txt')
word = dictionary[rand(dictionary.length - 1)].chomp

p word
