# seeds.rb is a way of automating the population of the database with testing data.

(0..10).each do |i|
    Example.create(name: "Example item #{i}", description: "This is the #{i.ordinalize} example item")
end