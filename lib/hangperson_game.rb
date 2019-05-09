class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word, :guesses, :wrong_guesses
  
  def guess(letter)
    letter = letter || ""
    raise ArgumentError if (letter == nil) || (letter =~ /[^[:alpha:]]/ ) || (letter.to_s == ' ') || !(letter =~ /^[A-z]$/i)
    letter.downcase!
    
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    
    return false if letter.length!= 1
    
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    return true
  end
  
  
  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end
      return result
  end
  
  
  def check_win_or_lose
    if word_with_guesses.downcase == @word.downcase
      return :win
    elsif @wrong_guesses.length >=7
      return :lose
    else 
      return :play
    end
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
