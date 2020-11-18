puts "Cleaning previous data"
ShippingCategory.destroy_all

puts "Starting seed"

weights = [250, 500, 750, 1000, 2000, 5000, 10000, 15000, 30000]

prices = { "METRO": [495, 645, 735, 799, 915, 1410, 2050, 2600, 3220],
    "Outre-Mer 1": [980, 980, 1490, 1490, 2030, 3045, 4880, 10200, 11200],
    "Outre-Mer 2": [1190, 1190, 1780, 1780, 3150, 5260, 10300, 23500, 27000],
    "UE": [1290, 1290, 1595, 1595, 1805, 2310, 3810, 5600, 7250],
    "Eastern Europe Norvège and Maghreb": [1920, 1920, 2290, 2290, 2505, 3220, 5330, 7235, 8840],
    "Rest of the world": [2810, 2810, 3125, 3125, 4295, 6290, 11890, 16900, 20600]
}

known_countries = ["FR", "AD", "MC", "GF", "GP", "MQ", "YT", "MF", "PM", "BL", "WF", "PF", "NC", "TF", "AT", "DE", "BE", "BG", "HR", "CY", "DK", "ES", "EE", "FI", "GR", "HU", "IE", "IT", "LV", "LT", "LU", "MT", "NL", "PL", "PT", "CZ", "RO", "GB", "SK", "SI", "SE", "CH", "LI", "VA", "SM", "DZ", "NO", "MR", "EH", "MA", "TN", "LY", "BY", "BA", "MD", "ME", "AL", "MK"]

countries_classification = {
  "METRO": ["FR", "AD", "MC"],
  "Outre-Mer 1": ["GF", "GP", "MQ", "YT", "MF", "PM", "BL"],
  "Outre-Mer 2": ["WF", "PF", "NC", "TF"],
  "UE": ["AT", "DE", "BE", "BG", "HR", "CY", "DK", "ES", "EE", "FI", "GR", "HU", "IE", "IT", "LV", "LT", "LU", "MT", "NL", "PL", "PT", "CZ", "RO", "GB", "SK", "SI", "SE", "CH", "LI", "VA", "SM"],
  "Eastern Europe Norvège and Maghreb": ["DZ", "NO", "MR", "EH", "MA", "TN", "LY", "BY", "BA", "MD", "ME", "AL", "MK"],
  "Rest of the world": ["ZZ"]
}


area_name = ["METRO", "Outre-Mer 1", "Outre-Mer 2", "UE", "Eastern Europe Norvège and Maghreb", "Rest of the world"]

ISO3166::Country.countries.each do |country|
  weights.each_with_index do |weight, index|
    if known_countries.include? country.alpha2
      countries_classification.each do |k,v|
        if countries_classification[k].include? country.alpha2
          ShippingCategory.create(name: country.name, alpha2: country.alpha2, weight: weight, price_cents: prices[k][index])
        end
      end
    else
      ShippingCategory.create(name: country.name, alpha2: country.alpha2, weight: weight, price_cents: prices[:"Rest of the world"][index])
    end
  end
end
