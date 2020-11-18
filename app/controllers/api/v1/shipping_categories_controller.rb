class Api::V1::ShippingCategoriesController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    country = params["country"]
    weight = params["weight"].to_i
    user_in_LA = params["user_in_LA"] == "true"


    weight_partition = { integerDivision: weight / 30000, remainingWeight: weight % 30000 }
    if user_in_LA && params["country"] == "FR"
      max_fare = 0
      remaining_cost = 0
    else
      max_fare = ShippingCategory.where(alpha2: country).where("weight >= 30000", weight).max.price_cents.to_f
      remaining_cost = ShippingCategory.where(alpha2: country).where("weight >= ?", weight_partition[:remainingWeight]).min.price_cents.to_f
    end

    shipping_cost = max_fare * weight_partition[:integerDivision] + remaining_cost

    @shipping_category = { name: country, price_cents: shipping_cost }
  end
end
