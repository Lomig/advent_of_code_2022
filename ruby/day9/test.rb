def return_array(arg1, arg2)
 [1, 2].tap do |mon_array|
    mon_array = mon_array << 3
    puts mon_array.inspect
  end
end

