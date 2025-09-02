class CalculateCityRatingService < BaseService
  def initialize(city)
    super()
    @total_weighted_rating = 0
    @city = city
  end

  def call
    calculate_rating
  end

  private

  def calculate_rating
    reviews = @city.reviews
    return if @city.calculated

    if reviews.empty?
      @city.update(calculated: true)
      return
    end

    reviews.select(:total_rating, :weight).each do |review|
      @total_weighted_rating += review.total_rating * review.weight
    end

    @total_weighted_rating = @total_weighted_rating.to_f / reviews.size

    @city.update(rating: @total_weighted_rating.round(2), calculated: true)
  rescue StandardError => e
    add_error("Failed to calculate city rating: #{e.message}")
  end
end
