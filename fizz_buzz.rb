class Basic

  def linkedin (lower = 1, upper = 100)

    (lower..upper).each { |num|
      if num % 5 == 0 and num % 10 == 0 then puts "FizzBuzz"
      elsif num % 5 == 0 then puts "Fizz"
      elsif num % 10 == 0 then puts "Buzz"
      else puts num
      end
    }
  end
end

args = [1,1000]
a = Basic.new
a.linkedin(*args)

