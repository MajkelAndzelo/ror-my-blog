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
      raise ArgumentError, "Division by zero" if b == 0
      a / b
    end
  end
  