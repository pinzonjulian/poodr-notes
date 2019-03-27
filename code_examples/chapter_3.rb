# INJECTING DEPENDENCIES

# Bad
class Gear
  attr_deader :chainring, :cog, :rim, :tire
  
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
    
  end
  
  def gear_ratio
    # Gear needs to know that the Wheel class exists deep inside the gear_ratio method.
    radio * Wheel.new(rim, tire).diameter
  end
end

# Good
class Gear
  # using wheel as an argument cut the dependency   
  attr_deader :chainring, :cog, :wheel
  
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
  
  def gear_ratio
    radio * wheel.diameter
  end
end

# ISOLATING DEPENDENCIES
# Assuming you can't change the arguments or cannot pass wheel to Gear

# Option 1: Move dependency from Gear ratio (see line 17) to Gear's initialization method.
class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

# Option 2
# Lazily create a new instance of Wheel using ||= operator. New instance of wheel is deferred until gear_inches invokes wheel.
class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * wheel.diameter
  end
  
  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

# ISOLATE VULNERABLE EXTERNAL MESSAGES
# A good way to understand messages is by using the term "send".
# In ruby a method can be called by its name (example: ratio) or by sending the "ratio" message to it's parent class. (ex: Gear.new(args).send('ratio')

# BAD
def gear_inches
  ratio * wheel.diameter
  # otherwise written as: self.send('ratio') * wheel.send('diameter') "send ratio message to self. send diameter message to wheel'   
end

# GOOD
def gear_inches
  # some scary math
  foo = some_intermediate_result * diameter
  # more lines of scary math
end

def diameter
  # encapsulate method from wheel in a method from the same class (self)
  # in this way if the definition of diameter changes, you only need to change it here and not everywhere wheel.diameter appears
  wheel.diameter
end

# REMOVE ARGUMENT-ORDER DEPENDENCIES

# BAD
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
end
# You explicitly need to know the order of the arguments
Gear.new(26, 1.5).gear_inches

# GOOD
# Option 1: Keyword arguments (not in 2013 edition)
def initialize(chainring:, cog:, :wheel)
  # ...
end
Gear.new(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))

# Option 2: using hashes
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end
end

Gear.new(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))

# Explicitly defining defaults using ||
def initialize(args)
  @chainring = args[:chainring] || 40
  @cog = args[:cog] || 18
  @wheel = args[:wheel]
end

# Explicitly defining defaults using fetch
def initialize(args)
  @chainring = args.fecht(:chainring, 40)
  @cog = args.fecht(:cog, 18)
  @wheel = args[:wheel]
end

# isolate defaults in a separate method

def initialize(args)
  args = defaults.merge(args)
  @chainring = args[:chainring]
end

def defaults
  { chainring: 40, cog: 18 }
end

# if your defaults are more than simple nubmers or stirngs, implement a defaults method

# isolate multiparameter initialization

# when gear is part of an external interface

module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end
  end
end

# YOUR WRAPPER: protect yourself from changes. The wrapper becomes the object you'll use in your code

module GearWrapper
  def self.gear(args)
    SomeFrawork::Gear.new(args[:chainring], args[:cog], args[:wheel])
  end
end

    
# Managing Dependency direction
