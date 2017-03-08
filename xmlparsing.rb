require 'nokogiri'

xml_file = File.read("#{File.dirname(__FILE__)}/sample_files/sample.xml")

doc = Nokogiri::XML.parse(xml_file)
puts doc
doc.xpath('//*').each do
|sitcom_element|
  puts "\nName : "+sitcom_element.xpath('name').text
  count=1
  sitcom_element.xpath('characters/character').each do
  |character_element|
    puts "    #{count}.Charachter : " + character_element.text
    count=count+1
  end
end