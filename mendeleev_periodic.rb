require 'json'

file = File.read("#{__dir__}/data/elements.json")
elements = JSON.parse(file)

puts "We have elements: #{elements.keys.size}"
nice_collection = ""
elements_hash = {}
table_element = []

x = 0
y = 0

element_position_from_xml = []

elements.keys.each_with_index do |element, index|
  elements_hash.store(element, elements[element].dig('symbol'))
  nice_collection << "#{index + 1}. #{element.capitalize} (#{elements[element].dig('symbol')}), "
  table_element.push (element)
end

118.times do |index|

  ab = elements[table_element[index]].dig('symbol')
  ax = elements[table_element[index]].dig('xpos').to_i
  ay = elements[table_element[index]].dig('ypos').to_i

  element_position_from_xml << { "Element" => [ab],
                                 "x" => [ax],
                                 "y" => [ay]
  }
end

index = 0

9.times do
  y += 1
  18.times do
    x += 1
    if x == element_position_from_xml[index]["x"][0] && y == element_position_from_xml[index]["y"][0]
      print element_position_from_xml[index]["Element"][0]
      index += 1
    else
      print "-"
    end
    x = 0 if x == 18
  end
  puts  ""
end

puts "What element are you up to?"
element_key = gets.chomp.downcase
element_key = element_key.to_i if !element_key.to_i.zero?
element_key = elements.keys.to_a[element_key - 1] if !element_key.to_i.zero?

if !elements_hash.key(element_key.capitalize).nil?
  element_key = elements_hash.key(element_key.capitalize)
end

if elements.has_key?(element_key)
  element = elements[element_key]
  puts "Number: #{element['number']}"
  puts "Name: #{element['name']}"
  puts "Symbol: #{element['symbol']}"
  puts "Discovered by: #{element['discovered_by']}"
  puts "Density: #{element['density']} g/L"
  puts "Boil: #{element['boil']}"
  puts "Melt: #{element['melt']}"
  puts "Molar heat: #{element['molar_heat']}"
  puts "Summary: #{element['summary']}"
  puts "Appearance: #{element['appearance']}"
else
  puts "Don't know such an element."
end
