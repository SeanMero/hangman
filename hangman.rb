dictionary = File.readlines('google-10000-english-no-swears.txt')
word = dictionary[rand(dictionary.length - 1)].chomp until word.to_s.length > 4 && word.to_s.length < 13

p word
