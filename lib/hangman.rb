class Hangman
  attr_accessor :secret_word, :words, :letters

  def initialize
    self.words = File.read('google-10000-english-no-swears.txt').split
    self.secret_word = generate_secret_word
    self.letters = ('a'..'z').to_a
  end

  def generate_secret_word
    loop do
      secret_word = words.sample
      return secret_word.downcase if secret_word.length.between?(5, 12)
    end
  end

  def guess
    loop do
      print 'Enter a guess: '
      letter = gets.chomp
      return letter if letters.include? letter

      puts 'Please a valid guess.'
    end
  end

  def correct_guess?(guess)
    secret_word.include?(guess) ? true : false
  end
end
