# part1: Hello World ------------------------------------------------

=begin
class HelloWorldClass
  def initialize(name)
    @name = name.capitalize
  end
  def sayHi
    puts "Hello #{@name}!"
  end
end
hello = HelloWorldClass.new("Hannah")
hello.sayHi
=end

# part2: Strings ----------------------------------------------------
=begin
def palindrome?(string)
  var = string.downcase
  var = var.gsub(/\W/, "").gsub(/\d/, "")
  if var == var.reverse
    puts "#{ string } is a palindrome."
  else
    puts "#{ string } is not a palindrome."
  end
end

# Testing
t1 = "A man, a plan, a canal -- Panama"
t2 = "Abracadabra"
t3 = "Madam, I'm Adam!"
palindrome?(t1)
palindrome?(t2)
palindrome?(t3)
=end

=begin
def count_words(string)
  hash = {}
  word = string.downcase.scan(/\w+/).each do |word|
    hash[word] = hash[word] ? hash[word] + 1:1
  end
  hash.each do |x|
    p x
  end
  return hash
end

# Testing
count_words("A man, a plan, a canal -- Panama")
count_words("Doo bee doo bee doo")
=end

# part3: Rock Paper Scissors ----------------------------------------

=begin
class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
  rps = ["r","p","s"]
  raise WrongNumberOfPlayersError unless game.length == 2
  stratA = game[0][1].downcase
  stratB = game[1][1].downcase
  if rps.include?(stratA) && rps.include?(stratB)
    if stratA == stratB || stratA+stratB == "rs" || stratA+stratB == "sp" || stratA+stratB == "pr"
      winner = game[0]
    else
      winner = game[1]
    end
  else
    raise NoSuchStrategyError
  end
  return winner
end

def rps_tournament_winner(game)
  if game[0][1].is_a?(String)
    rps_game_winner(game)
  else
    winnerA = rps_tournament_winner(game[0])
    winnerB = rps_tournament_winner(game[1])
    rps_tournament_winner([winnerA, winnerB])
  end
end

# Testing
game = [[[["Armando", "P"], ["Dave", "S"]],[["Richard", "R"], ["Michael", "S"]],],[[["Allen", "S"], ["Omer", "P"]],[["David E.", "R"],["Richard X.", "P"]]]]
rps_tournament_winner(game)
=end

# part4: Anagrams ---------------------------------------------------

=begin
def combine_anagrams(words)
  anagrams = []
  count = 0
  until words.empty?
    current = words.first
    group, words = words.partition {|this| current.downcase.chars.sort.join.eql?(this.downcase.chars.sort.join)}
    count += 1
    anagrams[count-1] = group
  end
  return anagrams
end

# Testing
list = ["cars", "for", "potatoes", "racs", "four", "scar", "creams", "scream"]
combine_anagrams(list)
=end
