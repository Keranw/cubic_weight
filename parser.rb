require 'open-uri'
require 'json'
require 'uri'

class Parser
  def initialize link, result
    @link = link
    @flag = true
    @result = result
  end

  def parse_link
    begin
      # read data from endpoint
      @result = JSON.parse(open(@link).read)
    rescue
      # stop program when input link is invalid
      @flag = false
      puts "invalid input link " + @link
    end
    deal_with_result
    @flag
  end

  def deal_with_result
    if @flag == true
      calculate_flag = true
      next_flag = true
      # calculate when input JSON has objects data
      if @result["objects"].nil? || @result["objects"].empty?
        calculate_flag = false
      else
        my_calculator = Calculator.new(@result["objects"], @link)
        my_calculator.calculate
      end
      # direct to next page when input JSON has next link path
      if @result["next"].nil? || @result["next"].empty?
        next_flag = false
      else
        # resemble next link with host address and path
        @link[URI(@link).path] = @result["next"]
        next_parser = Parser.new(@link, "")
        next_parser.parse_link
      end
    else
      calculate_flag = false
      next_flag = false
    end
    [@flag, calculate_flag, next_flag]
  end

end
