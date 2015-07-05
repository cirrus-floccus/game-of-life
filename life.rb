Field = Array

class Field 

  def initialize(x, y)
    @width = x
    @length = y
    @impl = []
  end

  def defecate 
    for y in 0...@length
      for x in 0...@width
        print @impl[@width * y + x].to_s + " "
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
    return neighbours
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
    @field = field
    field.write_at(x, y, self)
    if rand() > 0.7
      @alive = true
    else
      @alive = false
    end
  end

  def despawn
    @alive = false
  end

  def to_s
    if dead?
      "·"
    else
      "●"
    end
  end

  def spawn
    @alive = true
  end

  def dead?
    return not(@alive)
  end

  def check_neighbours
    neighbours = @field.get_neighbours(@x, @y).reject!{|cell| cell.dead?}
    if neighbours.length == 3
      spawn
    elsif neighbours.length < 2 or neighbours.length > 3
      despawn
    else
    end
  end

end

def fill_field(field)
  for x in 0..field.width
    for y in 0..field.length
      field.write_at(x, y, Cell.new(field, x, y))
    end
  end
end

field = Field.new(10, 10)

fill_field(field)

#print field.get_neighbours(5, 5).delete_if{|cell| cell.dead?}

loop do
  field.defecate
  field.next_turn
  gets
end

__END__
○
●
