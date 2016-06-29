class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_space(space_id)
    contents[space_id.to_s] ||= 0
    contents[space_id.to_s] += 1
  end

  def total
    contents.values.sum
  end

  def count_of(space_id)
    contents[space_id.to_s]
  end

  def spaces
    contents.map { |space_id, _quantity| Space.find(space_id) }
  end

  def total_price
    spaces.map do |space|
      count_of(space.id) * space.price.to_f.round(2)
    end.reduce(:+)
  end

  def remove_space(space_id)
    contents.delete_if { |id, _quantity| id == space_id.to_s }
  end

  def update_quantity(id, direction)
    if direction == "plus"
      contents[id.to_s] += 1
    elsif direction == "minus" && one?(id)
      remove_space(id)
    else
      contents[id.to_s] -= 1
    end
  end

  def one?(id)
    contents[id.to_s] == 1
  end
end
