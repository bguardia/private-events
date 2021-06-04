# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# USERS

require 'csv'

puts "Creating users..."
csv_file = File.open("./db/users.csv", "r")
user_data = CSV.parse(csv_file, headers: true)
user_data.each do |row|
    User.create(name: row["name"],
                email: row["email"],
                password: row["password"],
                password_confirmation: row["password_confirmation"])
end

# EVENTS
puts "Creating events..."
dummy_text = "Duis posuere diam suscipit ipsum porta, a iaculis sem fringilla. Morbi sagittis tincidunt dictum. Mauris vitae dapibus purus. Proin tempus eros in diam imperdiet varius. Maecenas id justo pulvinar, sagittis tortor eu, aliquet massa. Vivamus nibh nulla, suscipit vel auctor mollis, lacinia nec elit. Nulla ornare lacinia velit, ut auctor tortor fringilla a."
hosts = User.find((1..10).to_a)
current_date = DateTime.current
hosts.each_with_index do |host, i|
    5.times do |c|
        host.hosted_events.create(title: "#{host.name}'s Weekly Get-Together",
                                  body: dummy_text,
                                  start_date: current_date - c*7 - i,
                                  end_date: (current_date - c*7 - i).advance(hours: 2))
    end
end

# ATTENDEES
puts "Adding attendees..."
events = Event.all
users = User.all
usr_count = users.size
prng = Random.new
events.each do |event|
    rand_start = prng.rand(usr_count)
    rand_end = rand_start + prng.rand(usr_count - rand_start)
    event.attendees << users[rand_start, rand_end]
end




