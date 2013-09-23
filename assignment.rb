# Hannah Tuell
# CSCI 3308 - Fall 2013
# Collaborators:
#     Paul Kubala
#

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
bean = JellyBean.new("JellyBean", 190, "black licorice")
cake = Dessert.new("cake", 210)
puts "The cake is delicious?"
puts cake.delicious?
puts "The Jellybean is delicious?"
puts bean.delicious?
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# Part 2 - Classes ------------------------------------------------------------
class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s    #make sure it is a string
        attr_reader attr_name        #create the attribute's getter
        attr_reader attr_name+"_history" #create bar_history getter
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
#test cases
f = Foo.new
f.bar = 1
f.bar = 2
f.bar_history 
