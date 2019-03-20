class Gear
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
