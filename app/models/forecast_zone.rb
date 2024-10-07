class ForecastZone
  attr_reader :id, :name

  def initialize(id:, name:, type:)
    @id = id
    @name = name
    @type = type
  end

  def type
    return "London Borough" if @type == 1

    "Area"
  end

  # :nocov:
  def inspect
    "#<#{self.class.name} @id=#{id} @name=#{name} @type=#{@type}>"
  end
  # :nocov:
end
