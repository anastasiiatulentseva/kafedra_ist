require 'csv'
require 'awesome_print'
require 'open-uri'

filename = 'https://gist.githubusercontent.com/anastasiiatulentseva/212189a64a91483990a915263722ea8b/raw/cd785d76c17385daac96e7845ca5e088e395f3d6/specialties.csv'
csv_text = open(filename).read
csv = CSV.parse(csv_text, :col_sep => ";")
csv.each do |row|
  name = row.first
  ap name
  Specialty.create!(name: name)
end
