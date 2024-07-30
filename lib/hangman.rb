class Hangman
  attr_accessor :secret_word, :words

  def initialize
    self.words = File.read('google-10000-english-no-swears.txt').split
    self.secret_word = generate_secret_word
  end

  def generate_secret_word
    loop do
      secret_word = words.sample
      return secret_word if secret_word.length.between?(5, 12)
    end
  end
end
