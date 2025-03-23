# frozen_string_literal: true

require 'csv'
require 'erb'
require 'google/apis/civicinfo_v2'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[...5]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('key.txt').strip

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def create_letter_file(id, letter)
  filename = "output/thanks_#{id}.html"

  Dir.mkdir('output') unless Dir.exist?('output')

  File.open(filename, 'w') do |file|
    file.puts letter
  end
end

puts 'Event Manager Initialized!'
puts 'Processing...'

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

template = ERB.new File.read('letter-template.erb')

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  letter = template.result(binding)
  create_letter_file(id, letter)
end

puts 'Done!'
