module B
  def self.a
    2
  end
end

class A
  extend B
  def self.a
    1
  end
#  class <<self
#    alias_method :aa, :a
#  end
#  def self.a
#    super
#  end  
end

puts A.a!
