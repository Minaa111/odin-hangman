class Hangman
  attr_accessor :secret_word, :words, :letters, :incorrect_guesses, :correct_guesses, :tries, :progress

  def initialize
    self.words = File.read('google-10000-english-no-swears.txt').split
    self.secret_word = generate_secret_word.split('')
    self.letters = ('a'..'z').to_a
    self.incorrect_guesses = []
    self.correct_guesses = []
    self.tries = 10
    self.progress = Array.new(secret_word.length, '_')
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

      puts 'Please enter a valid guess.'
    end
  end

  def correct_guess?(guess)
    secret_word.include?(guess) ? true : false
  end

  def show_progress
    correct_guesses.each do |letter|
      secret_word.each_with_index do |secret_letter, index|
        progress[index] = letter if secret_letter == letter
      end
    end
    puts progress.join(' ')
  end

  def show_incorrect_guesses
    puts 'Incorrect guesses: ' + incorrect_guesses.to_s
  end

  def show_left_tries
    puts "Number of tries left: #{tries}"
  end

  def win?
    progress.join('') == secret_word.join('')
  end

  def play_round
    new_guess = guess
    if correct_guess?(new_guess)
      correct_guesses << new_guess
    elsif incorrect_guesses.include?(new_guess)
      puts 'You have already guessed this incorrect letter'
      show_incorrect_guesses
    else
      incorrect_guesses << new_guess
      show_incorrect_guesses
      self.tries -= 1
      show_left_tries
    end
    show_progress
  end

  def intro
    puts "You have #{tries} attempts to guess the secret word. In each attempt, you will receive feedback on whether you guessed a correct or incorrect letter. Good luck!"
  end

  def play
    generate_secret_word
    intro
    play_round
    until tries.zero?
      play_round
      if win?
        puts 'You guessed the secret word!'
        break
      end
    end

    puts "The secret word was '#{secret_word.join('')}'." unless win?
  end
end
