class Calculator
    def self.add(a, b)
      a + b
    end
  
    def self.subtract(a, b)
      a - b
    end
  
    def self.multiply(a, b)
      a * b
    end
  
    def self.divide(a, b)
      if b == 0
        raise ArgumentError.new('Cannot divide by zero')
      end
  
      a / b
    end
  end
  