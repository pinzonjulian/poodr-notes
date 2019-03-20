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
