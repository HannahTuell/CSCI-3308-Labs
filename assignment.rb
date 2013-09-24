# Hannah Tuell
# CSCI 3308 - Fall 2013
# Collaborators:
#     Paul Kubala
#     Ashley Morris

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

# test cases
#cake = Dessert.new("cake", 190)
#cake = Dessert.new("cake", 210)
#puts cake.healthy?
#puts cake.delicious?

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

# test cases
#bean = JellyBean.new("JellyBean", 190, "black licorice")
#cake = Dessert.new("cake", 210)
#puts "The cake is delicious?"
#puts cake.delicious?
#puts "The Jellybean is delicious?"
#puts bean.delicious?

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

# test cases
#f = Foo.new
#f.bar = 1
#f.bar = 2
#p f.bar_history # => if your code works, should be [nil, 1, 2]

# -----------------------------------------------------------------------------
# Part 3 - More OOP -----------------------------------------------------------
#     a) Currency Conversion - add methods to the class Numerics.

class Numeric
	@@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' =>1}
	def method_missing(method_id)
		singular_currency = method_id.to_s.gsub( /s$/, '') #=> gets rid of spaces and converts thing to string
		if @@currencies.has_key?(singular_currency)
			self * @@currencies[singular_currency]
		else
			super
		end
	end

	def in(currency) #=> method takes in currency
		singular_currency = currency.to_s.gsub( /s$/, '') #=> converts it to string
		self / @@currencies[singular_currency] #=> goes into class variable, finds value from key
	end
end

# -----------------------------------------------------------------------------
#     b) Palindromes:  Adapt your solution from the "palindromes" question so 
#        that instead of writing palindrome?("foo") you can write 
#        "foo".palindrome? (Hint: this should require fewer than 5 lines 
#         of code.)

class String
	def palindrome?
		temp_str = self.downcase.gsub(/\W/, "")
		temp_str == temp_str.reverse 
	end
end

# -----------------------------------------------------------------------------
#     c) Palindromes again: Adapt your palindrome solution so that it works on 
#        Enumerables. That is: [1,2,3,2,1].palindrome? # => true

module Enumerable
	def palindrome?
		array = {} #=> make empty array
		self.collect{|num| num} == self.collect{|num|num}.reverse #=> compare array of numbers to its reversed self
	end
end

# -----------------------------------------------------------------------------
# Part 4 - Blocks -------------------------------------------------------------
#   Given two collections (of possibly different lengths), we want to get the 
#   Cartesian product of the sequences. A Cartesian product is a sequence that 
#   enumerates every possible pair from the two collections, where the pair 
#   consists of one element from each collection. 

class CartesianProduct
	include Enumerable

		def initialize(sequence1, sequence2)
			@sequence1 = sequence1
			@sequence2 = sequence2
		end

		def each
			unless @sequence1.empty? && @sequence2.empty? #=>don't execute if the sequences are empty
			combination_sequence = []
			@sequence1.each do |s1|
				combination_sequence << @sequence2.each {|s2| yield [s1] << s2} #=>iterate through the first sequence while putting the second sequence in an array with the first		
			end
		end
	end
end