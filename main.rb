require_relative 'lib/hangman'

hangman = Hangman.new
puts hangman.secret_word
guess = hangman.guess
puts hangman.correct_guess?(guess)
