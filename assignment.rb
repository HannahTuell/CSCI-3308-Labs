# Assignment 2: Programming in Ruby
# CSCI 3308 - Fall 2013
# -----------------------------------------------------------------------------
# Author: Hannah Tuell
#
# Collaborators:
#     Paul Kubala
#     Ashley Morris
#       I also looked through many question/answers on Stack Overflow
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Part 1 - Classes ------------------------------------------------------------
#     a) Create a class Dessert with getters and setters for name and calories.
#        Define instance methods healthy?, which returns true if a dessert
#        has less than 200 calories, and delicious? which returns true for all
#        desserts.

class Dessert
  # initializes instance variables name and calories
  def initialize(name, calories)
    @name     = name
    @calories = calories
  end

  # returns true if a dessert has less than 200 calories
  def healthy?
    if (@calories < 200)
      return true
    else
      return false
    end
  end

  #returns true for all dessert as all dessert is delicious
  def delicious?
    return true
  end

end

=begin
# test cases
cake = Dessert.new("cake", 190)
cake = Dessert.new("cake", 210)
puts cake.healthy?
puts cake.delicious?
=end

# -----------------------------------------------------------------------------
#     b)Create a class JellyBean that extends Dessert, and add a getter and
#       setter for flavor. Modify delicious? to return false if the flavor is
#       "black licorice" (but delicious? should still return true for all other
#       flavors and for all non-JellyBean desserts).

class JellyBean < Dessert
  def initialize(name, calories, flavor)
    @flavor = flavor
  end

  def delicious?
    if (@flavor == "black licorice")
      return false
    else
      return true
    end
  end
end

=begin
# test cases
bean = JellyBean.new("JellyBean", 190, "black licorice")
cake = Dessert.new("cake", 210)
puts "The cake is delicious?"
puts cake.delicious?
puts "The Jellybean is delicious?"
puts bean.delicious?
=end

# -----------------------------------------------------------------------------
# Part 2 - Object-Oriented Programming ----------------------------------------
#   Module provides a method, attr_accessor, which uses meta-programming to 
#   create getters and setters for object attributes on the fly. Define a
#   method attr_accessor_with_history that provides the same functionality as 
#   attr_accessor but also tracks every value the attribute has ever taken. 

class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s        # make sure it's a string
        attr_reader attr_name             # create the attribute's getter
        attr_reader attr_name+"_history"  # create bar_history getter
        # this block will be evaluated in the context of the runtime class
        # (ie. Foo). if the history has not been defined, then define it
        # with the new value, if it has, thn add the value to the history
        # array
        class_eval %Q"
            def #{attr_name}=(value)
                if !defined? @#{attr_name}_history
                    @#{attr_name}_history = [@#{attr_name}]
                end
                @#{attr_name} = value
                @#{attr_name}_history << value
            end"
    end
end

class Foo
    attr_accessor_with_history :bar
end

=begin
# test cases
f = Foo.new
f.bar = 1
f.bar = 2
p f.bar_history # => if your code works, should be [nil, 1, 2]
=end

# -----------------------------------------------------------------------------
# Part 3 - More OOP -----------------------------------------------------------
#     a) Currency Conversion - add methods to the class Numerics.

class Numeric
	@@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' =>1}
	def method_missing(method_id)
	    # converts the passed currency to a string and removes spaces and trailing 's'
		singular_currency = method_id.to_s.gsub( /s$/, '') 
		# if the desired currency (method_id) is defined in currencies
		# then grab the conversion value and perform the conversion
		if @@currencies.has_key?(singular_currency)
			self * @@currencies[singular_currency]
		else
			super
		end
	end

	def in(currency) 
	    # converts the passed currency to a string and removes spaces and trailing 's'
		singular_currency = currency.to_s.gsub( /s$/, '')
		# finds the conversion value for the passed currency and divides
		# the 'self' object by that value to perform the conversion
		self / @@currencies[singular_currency]
	end
end

=begin
# test cases
p fiveDollarsInEuros = 5.dollars.in(:euros)
p tenEurosInRupees = 10.euros.in(:rupees)
p oneDollarInRupees = 1.dollar.in(:rupees)
=end

# -----------------------------------------------------------------------------
#     b) Palindromes:  Adapt your solution from the "palindromes" question so 
#        that instead of writing palindrome?("foo") you can write 
#        "foo".palindrome? (Hint: this should require fewer than 5 lines 
#         of code.)

# previous version from lab2.rb
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
=end

class String
	def palindrome?
		var = self.downcase.gsub(/\W/, "")  # removes non-words and upper-case
        var == var.reverse                  # returns true if the reverse is the same
    end
end

=begin
# test cases
t1 = "A man, a plan, a canal -- Panama"
t2 = "Abracadabra"
t3 = "Madam, I'm Adam!"
p t1.palindrome?
p t2.palindrome?
p t3.palindrome?
=end

# -----------------------------------------------------------------------------
#     c) Palindromes again: Adapt your palindrome solution so that it works on 
#        Enumerables. That is: [1,2,3,2,1].palindrome? # => true

module Enumerable
    # steps through the elements of the array and compares those
    def palindrome?
        self.collect{|v| v} == self.collect{|v| v}.reverse
    end
end

=begin
# test cases
p [1,2,3,2,1].palindrome?
p [5,5,5,6,5].palindrome?
t1 = "A man, a plan, a canal -- Panama"
p t1.palindrome?
=end

# -----------------------------------------------------------------------------
# Part 4 - Blocks -------------------------------------------------------------
#   Given two collections (of possibly different lengths), we want to get the 
#   Cartesian product of the sequences. A Cartesian product is a sequence that 
#   enumerates every possible pair from the two collections, where the pair 
#   consists of one element from each collection. 


class CartesianProduct
    include Enumerable
    
    # constructor
    def initialize(seqA, seqB)
        @product = Array.new
        # iterates through each passed sequence, isolating each element and builds an
        # array holding a,b pairings called 'product'
        seqA.each do |a|
            seqB.each do |b|
                temp = Array.new
                temp.push(a,b)
                @product.push(temp)
            end
        end
        @product
    end

    # instance method
    # steps through each element of the product array (each: a,b) and applies the passed block
    # description on them
    def each
        @product.each { |i| yield(i) }
    end
end

=begin
# test cases
c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]

c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
# Nothing printed since Cartesian product of anything with an empty
=end

# -----------------------------------------------------------------------------