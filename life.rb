class Field 

  def initialize(x, y)
    @width = x
    @length = y
    @impl = []
  end

  def defecate #Пилился раньше, сейчас не работает совсем.
    for y in 0...@length
      for x in 0...@width
        print @impl[@width * y + x] + " "
      end
      puts
    end
  end

  def get_neighbours(x, y)
    neighbours = []
    neighbours.push(self.read_at(x-1, y-1))
              .push(self.read_at(x, y-1))    
              .push(self.read_at(x+1, y-1))    
              .push(self.read_at(x-1, y))
              .push(self.read_at(x+1, y))
              .push(self.read_at(x-1, y+1))
              .push(self.read_at(x, y-1))
              .push(self.read_at(x+1, y+1))
  end

  def write_at(x, y, element) 
    return if x < 0 or x >= @width or y < 0 or y >= @length
    @impl[@width * y + x] = element
  end

  def read_at(x, y)
    return @impl[@width * y + x] if x > 0 and x <= @width and y > 0 and y <=@length
  end

  def next_turn
    self.each {|cell| cell.check_neighbours}
  end

  attr_reader :width 
  attr_reader :length

end



class Cell

  def initialize(field, x, y)
    @x = x
    @y = y
    @alive = false
    @field = field
    field.write_at(x, y, self)
  end

  def despawn
    @alive = false
  end

  def spawn
    @alive = true
  end

  def dead?
    return not(@alive)
  end

  def check_neighbours
    neighbours = @field.get_neighbours
    neighbours.reject!{|cell| cell.dead?}
    if neighbours.length == 3
      spawn
    elsif neighbours.length < 2 or neighbours.length > 3
      despawn
    else
    end
  end

end

field = Field.new(10, 10)

cell = Cell.new(field, 1, 1)


__END__
○
●
