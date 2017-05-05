
time    = Time.now.strftime("%Y_%m_%d.log")
tempdir = ENV["TMPDIR"]
$log_file = File.path("#{tempdir}logfile__#{time}.log")
puts "Log file: #{$log_file}"

# CUSTOM LOGGER
def logit (content)
  File.open($log_file, "a") do |file_handle|
    file_handle.write(content)
  end
end

# USING THE LOGGER
require 'logger'
$LOG = Logger.new($log_file)

$LOG.debug("#{Time.now}")
$LOG.error("#{Time.now}")
$LOG.info("#{Time.now}")


(1..3).each { |a| logit("#{Time.now}\n") }



# PRINT LOG FILE
File.open($log_file, "r") do |reader|
  reader.each_line { |line|
    puts line
  }
end
