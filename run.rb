require_relative 'parser.rb'
require_relative 'calculator.rb'

$ac_cw_sum = 0
$ac_count = 0

input_link = String.new(ARGV[0])
initial_parser = Parser.new(input_link, "")
initial_parser.parse_link

if $ac_count == 0
  puts 0
else
  puts "average cubic weight is " + ($ac_cw_sum / $ac_count).to_s + " gram"
end
