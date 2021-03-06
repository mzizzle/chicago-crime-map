require 'services/transformers/crime_transformer'
require 'models/crime'
require 'rest-client'

class CrimeService
  def self.retrieve_raw_crime_data
    RestClient.get "https://data.cityofchicago.org/api/views/bj7p-98q2/rows.json", {:params => {"max_rows" => 100}}
  end

  def self.get_crimes
    crimes = CrimeTransformer.parseCrimes retrieve_raw_crime_data
    crimes.select {|crime| !crime.latitude.nil? and !crime.longitude.nil?}
  end
end
