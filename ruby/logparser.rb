REGEX = /^(\d+.\d+.\d+.\d+) - - \[(.*)\]\s/


base_dir=File.dirname(__FILE__)
access_log="#{base_dir}/sample_files/access_log"

def parse_log (log_file)
  File.open(log_file, "r") { |reader|
    _count = 1
    reader.each_line { |line|

      # REGEX version loop
      line.scan(REGEX).each {|match|
        #puts  match
      }

      # REGEX version match
      line.scan(REGEX) {|match|
        puts  "Time is #{$2}"
      }

      # Split version
      split = line.split(" ")
      puts split[3]

      _count += 1
      return if _count > 5 # only 5 lines
    }
  }
end


parse_log(access_log)