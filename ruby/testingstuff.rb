require 'find'

time=Time.now() - 60 * 60 * 24 * 0.5
base_path = File.expand_path("../../../", __FILE__)

Find.find(base_path) do |item|
  item_type = File.directory?(item) ? :directory : :file

  if File.ctime(item) > time
    puts "#{item_type}:> #{item} is greater then #{time}"
  end


end


$file=__FILE__ + "_scratch"
def write_to_file(log)
  File.open($file, "a") { |writer|
    writer.write(log +"\n")

  }
end

File.open($file, "r") { |r|
  r.each_line { |l|
  puts l
  }
}


write_to_file("asdasdasd")