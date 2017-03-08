require 'nokogiri'

xml_file = File.read("#{File.dirname(__FILE__)}/sample_files/sample.xml")

doc = Nokogiri::XML.parse(xml_file)
#puts doc

# xpath can be //* for all elements /sitcom or /drama
# Note: anything begining with // will pull the whole tree and not just the value

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