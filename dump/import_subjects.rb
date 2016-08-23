require 'csv'
require 'awesome_print'
require 'open-uri'

filename = 'https://gist.githubusercontent.com/anastasiiatulentseva/6f65381b2ca5c945b2d65ea723d447cb/raw/247e0528e47ec3e3ab79787d61cb23a24848520a/subjects.csv'
csv_text = open(filename).read
csv = CSV.parse(csv_text, :col_sep => ";")

csv.each do |row|
  name, course_year, specialty = row

  existing_specialty = Specialty.where(name: specialty).first

  if existing_specialty
    Subject.create!(name: name, course_year: course_year, specialty_id: existing_specialty.id)
  end
end
