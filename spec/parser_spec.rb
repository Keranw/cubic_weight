require 'spec_helper'

describe Parser do

  before :each do
    $ac_cw_sum = 0
    $ac_count = 0
    $endpoint = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com/api/products/1"
    $mock_object = "\"objects\": [{
            \"category\": \"Air Conditioners\",
            \"title\": \"Window Seal for Portable Air Conditioner Outlets\",
            \"weight\": 235.0,
            \"size\": {
                \"width\": 26.0,
                \"length\": 26.0,
                \"height\": 5.0
            }
        }]"
    $mock_next = "\"next\":\"/api/products/5\""
  end

  describe "#new" do
    it "generate a Parser Object with a link" do
      @parser = Parser.new($endpoint, "")
      expect(@parser).to be_an_instance_of Parser
    end
  end

  describe "#parse_link" do
    it "fetch data from API endpoint" do
      @parser = Parser.new($endpoint, "")
      result = @parser.parse_link
      expect(result).to be(true)
    end
  end

  describe "#parse_link" do
    it "won't accept a string which is not a link" do
      @parser = Parser.new("abcd", "")
      result = @parser.parse_link
      expect(result).to be(false)
    end
  end

  describe "#parse_link" do
    it "won't accept a link of the page without necessary data" do
      @parser = Parser.new("https://www.google.com.au", "")
      result = @parser.parse_link
      expect(result).to be(false)
    end
  end

  describe "#deal_with_result" do
    it "get cubic weight data of all ACs and visit next page if it exists" do
      @parser = Parser.new($endpoint, "")
      @parser.parse_link
      expect($ac_count).to be(4)
    end
  end

  describe "#deal_with_result" do
    it "won't do calculation without objects" do
      mock_data = JSON.parse("{#{$mock_next}}")
      @parser = Parser.new($endpoint, mock_data)
      result = @parser.deal_with_result
      expect(result).to eq([true, false, true])
    end
  end

  describe "#deal_with_result" do
    it "won't do calculation when objects is null" do
      mock_data = JSON.parse("{\"objects\":null, #{$mock_next}}")
      @parser = Parser.new($endpoint, mock_data)
      result = @parser.deal_with_result
      expect(result).to eq([true, false, true])
    end
  end

  describe "#deal_with_result" do
    it "won't do calculation when objects is empty" do
      mock_data = JSON.parse("{\"objects\":\"\", #{$mock_next}}")
      @parser = Parser.new($endpoint, mock_data)
      result = @parser.deal_with_result
      expect(result).to eq([true, false, true])
    end
  end

  describe "#deal_with_result" do
    it "stop to read data if there is no next link" do
      mock_data = JSON.parse("{#{$mock_object}}")
      @parser = Parser.new($endpoint, mock_data)
      result = @parser.deal_with_result
      expect($ac_cw_sum).to eq(845)
      expect(result).to eq([true, true, false])
    end
  end

  describe "#deal_with_result" do
    it "stop to read data if next link is null" do
      mock_data = JSON.parse("{#{$mock_object}, \"next\":null}")
      @parser = Parser.new($endpoint, mock_data)
      result = @parser.deal_with_result
      expect($ac_cw_sum).to eq(845)
      expect(result).to eq([true, true, false])
    end
  end

  describe "#deal_with_result" do
    it "stop to read data if next link is empty" do
      mock_data = JSON.parse("{#{$mock_object}, \"next\":\"\"}")
      @parser = Parser.new($endpoint, mock_data)
      result = @parser.deal_with_result
      expect($ac_cw_sum).to eq(845)
      expect(result).to eq([true, true, false])
    end
  end

end
