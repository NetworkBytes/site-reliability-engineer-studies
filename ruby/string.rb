
def process_string(string)

  # print the left 10 characters
  puts string[0..10]

  # Get the first 10 characters starting at position 20
  puts string.slice(20,10)

  # Find occurrences of a character
  puts string.count("o")

  # Find index of charchter
  puts string.index('s')

  # Find and replace
  puts string.sub("sample", " - ")

  # replace using regex
  puts string.gsub(/(so)/, "#|||{$1}|||")

  # match groups using scan
  string.scan(/(so|lo)/).each { |match|
    puts match
  }

  # if statement matchs a regex
  if string =~ /lo/ then puts "yes" end

end


process_string("This is a sample long string so that we can do some manipulations")

