
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
              .delete_if{|e| e == nil}
              .delete_if{|cell| cell.dead? == true}
    return neighbours.size
    
  end


  def write_at(x, y, element) 
    if x < 0 or x >= @width or y < 0 or y >= @length
      return nil
    else
      return @impl[@width * y + x] = element
    end
  end

  def read_at(x, y)
    if x > 0 and x <= @width and y > 0 and y <=@length
      return @impl[@width * y + x]
    else
      return nil
    end
  end

  def next_turn
    @impl.each {|cell| cell.check_neighbours}
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
    if rand() > 0.85
      @alive = true
    else
      @alive = false
    end
  end

  def to_s
    if dead?
      "·"
    else
      "●"
    end
  end

  def dead?
    return not(@alive)
  end

  def check_neighbours
    #neighbours = @field.get_neighbours(@x, @y)
    neighbours = rand(9)
    if neighbours == 3
      @alive = true
    else
      @alive = false
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

field = Field.new(50, 50)
fill_field(field)

loop do
  field.defecate
  field.next_turn
  gets
end

__END__
○
●
