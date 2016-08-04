require 'csv'
require 'awesome_print'
require 'open-uri'

filename = 'https://gist.githubusercontent.com/anastasiiatulentseva/6f65381b2ca5c945b2d65ea723d447cb/raw/dbb3e0077bef2feb3edfcba6f3519b4bf7036bc3/subjects.csv'
csv_text = open(filename).read
csv = CSV.parse(csv_text, :col_sep => ";")
csv.each do |row|
  name, course_year, specialty = row
  ap row
  Subject.create!(name: name, course_year: course_year, specialty: specialty)
end
