class Field 

  def initialize(x, y)
    @width = x
    @length = y
    @impl = []
    (@width*@length).times do 
      @impl.push('○')
    end
  end

  def defecate
    for y in 0...@length
      for x in 0...@width
        print @impl[@width * y + x] + " "
      end
      puts
    end
  end

  def write_at(x, y, element) 
    return if x < 0 or x >= @width or y < 0 or y >= @length
    @impl[@width * y + x] = element
  end

end

field = Field.new(5, 5)
10.times do
  field.write_at(rand(5), rand(5), "●")
end


field.defecate
  



__END__
○
●