class Calculator
  def initialize data, link
    @data = data
    @link = link
  end

  def calculate
    @data.each do |f|
      if (f.has_key? "category") && (f.has_key? "size") && (!f["size"].nil?)
        if f["category"] == "Air Conditioners"
          if (!f["size"].empty?) &&
             (f["size"].has_key? "height") && (f["size"]["height"] > 0) &&
             (f["size"].has_key? "width") && (f["size"]["width"] > 0) &&
             (f["size"].has_key? "length") && (f["size"]["length"] > 0)
            #h(m) * w(m) * l(m) * 250 kilogram = h(cm) * w(cm) * l(cm) / 4 gram
            cubic_weight = f["size"]["height"] * f["size"]["width"] *
              f["size"]["length"] / 4
            $ac_cw_sum += cubic_weight
            $ac_count += 1
          else
            # skip objects without necessary data and report invalid data
            puts "invalid data " + f.inspect + " from " + @link
          end
        else
          # skip objects not belong to AC
        end
      else
        # skip objects without necessary data and report invalid data
        puts "invalid data " + f.inspect + " from " + @link
      end
    end
  end

end
