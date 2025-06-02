require_relative 'DistanceService'

class CargoCalculator
  attr_reader :weight, :length, :width, :height, :from, :to

  def initialize(weight:, length:, width:, height:, from:, to:)
    @weight = weight.to_f
    @length = length.to_f / 100 # переводим см в метры
    @width = width.to_f / 100
    @height = height.to_f / 100
    @from = from
    @to = to
  end

  def volume
    (length * width * height).round(3)
  end

  def distance
    DistanceService.get_distance(from, to)
  end

  def price_per_km
    if volume < 1
      1
    elsif weight <= 10
      2
    else
      3
    end
  end

  def total_price
    (distance * price_per_km).to_i
  end

  def result
    {
      weight: weight,
      length: (length * 100).to_i,
      width: (width * 100).to_i,
      height: (height * 100).to_i,
      distance: distance,
      price: total_price
    }
  end
end