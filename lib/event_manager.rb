# frozen_string_literal: true

require 'csv'
require 'erb'
require 'google/apis/civicinfo_v2'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[...5]
end

def clean_phonenumber(number)
  number = number.scan(/\d/)
  size = number.size

  number.shift if size == 11 && number[0] == 1

  return 'invalid' unless size == 10

  number.join('')
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('api.key').strip

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

def add_to_phonebook(name, number)
  file = File.open('phonebook.txt', 'a+')
  entry = "#{name}: #{number}"

  file.puts entry unless file.read.include?(entry)
  file.close
end

# create statistics for hash(es) that contain name and another hash
# example: {name: "something", hash: {number: 234, str: "bla, bla"}}
def create_statistics(*args)
  file = File.open('stats.txt', 'w')

  args.each do |arg|
    top = find_top_counts(arg[:hash], arg[:name])
    write_statistics(top, file, arg[:name])
  end
end

# write stats from hash to file
def write_statistics(hash, file, items = 'items')
  file.puts "TOP #{items.upcase}"
  hash.to_h.each do |key, value|
    file.puts "#{key}: #{value} registrations"
  end
  file.puts "\n"
end

# find top counts
def find_top_counts(hash, items = 'items')
  # find top 3
  top = hash.sort_by { |_key, value| value }.pop(3).reverse.to_h

  # sum of top 3
  top['sum'] = top.values.sum

  # total count of rest days/hours
  top["rest #{items}"] = (hash.to_a - top.to_a).to_h.values.sum

  # return top
  top
end

puts 'Event Manager Initialized!'
puts 'Processing...'

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

template = ERB.new File.read('letter-template.erb')

# create hashes to count reg days and hours
hours = Hash.new(0)
days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  number = clean_phonenumber(row[:homephone])
  zipcode = clean_zipcode(row[:zipcode])
  date = Time.strptime(row[:regdate], '%m/%d/%y %k:%M').utc

  legislators = legislators_by_zipcode(zipcode)

  letter = template.result(binding)
  create_letter_file(id, letter)

  add_to_phonebook(name, number)

  # count registration hours and days
  hours[date.hour] += 1
  days[date.strftime('%A')] += 1
end

# cretate stast.txt with stats for hours and days
create_statistics({ name: 'hours', hash: hours }, { name: 'days', hash: days })

puts 'Done!'
