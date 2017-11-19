require 'spec_helper'

describe Calculator do

  before :each do
    $ac_cw_sum = 0
    $ac_count = 0
    $mock_json = JSON.parse("{
            \"category\": \"Air Conditioners\",
            \"title\": \"Window Seal for Portable Air Conditioner Outlets\",
            \"weight\": 235.0,
            \"size\": {
                \"width\": 26.0,
                \"length\": 26.0,
                \"height\": 5.0
            }
        }")
  end

  describe "#new" do
    it "generate a Calculator object with JSON array" do
      @calculator = Calculator.new([$mock_json], "test_cases_1")
      expect(@calculator).to be_an_instance_of Calculator
    end
  end

  describe "#calculate" do
    it "get cubic weight with necessary data" do
      @calculator = Calculator.new([$mock_json], "test_cases_2")
      @calculator.calculate
      expect($ac_cw_sum).to eq(845)
      expect($ac_count).to be(1)
    end
  end

  describe "#calculate" do
    it "skip object without category" do
      $mock_json.delete("category")
      @calculator = Calculator.new([$mock_json], "test_cases_3")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe "#calculate" do
    it "skip object when category is null" do
      $mock_json["category"] = nil
      @calculator = Calculator.new([$mock_json], "test_cases_4")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe "#calculate" do
    it "skip object when category is empty" do
      $mock_json["category"] = ""
      @calculator = Calculator.new([$mock_json], "test_cases_5")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe "#calculate" do
    it "skip object without size" do
      $mock_json.delete("size")
      @calculator = Calculator.new([$mock_json], "test_cases_6")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe "#calculate" do
    it "skip object when size is null" do
      $mock_json["size"] = nil
      @calculator = Calculator.new([$mock_json], "test_cases_7")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe "#calculate" do
    it "skip object when size is empty" do
      $mock_json["size"] = ""
      @calculator = Calculator.new([$mock_json], "test_cases_8")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe '#calculate' do
    it "skip object not belong to AC" do
      $mock_json["category"] = "Gadgets"
      @calculator = Calculator.new([$mock_json], "test_cases_9")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe '#calculate' do
    it "skip object with illegal size data" do
      $mock_json["size"]["width"] = -26.0
      @calculator = Calculator.new([$mock_json], "test_cases_10")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

  describe '#calculate' do
    it "skip object without necessary size data" do
      $mock_json["size"].delete("width")
      @calculator = Calculator.new([$mock_json], "test_cases_11")
      @calculator.calculate
      expect($ac_cw_sum).to be(0)
      expect($ac_count).to be(0)
    end
  end

end
