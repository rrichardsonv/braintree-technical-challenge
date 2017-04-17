# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Seeding database from ./db/seeds.rb'

SEEDED_FRUITS = [{
    :name => "banana",
    :price_per_lb => 0.59,
    :description => "Bananas are a rich source of vitamin B6 and contain moderate amounts of vitamin C, manganese and dietary fiber. Although bananas are commonly thought to supply exceptional potassium content, their actual potassium content is relatively low per typical food serving at only 8\% of the Daily Value.",
    :display_url => "bana.jpg",
  }, {
    :name => "apple",
    :price_per_lb => 1.05,
    :description => "The apple is a deciduous tree, generally standing 1.8 to 4.6 m (6 to 15 ft) tall in cultivation and up to 12 m (39 ft) in the wild. When cultivated, the size, shape and branch density are determined by rootstock selection and trimming method. The leaves are alternately arranged dark green-colored simple ovals with serrated margins and slightly downy undersides",
    :display_url => "appl.jpg",
  }, {
    :name => "orange",
    :price_per_lb => 1.02,
    :description => "The word orange derives from the Sanskrit word for 'orange tree' (नारङ्ग nāraṅga), which is probably of Dravidian origin. The Sanskrit word reached European languages through Persian نارنگ (nārang) and its Arabic derivative نارنج (nāranj).",
    :display_url => "oran.jpg",
  }, {
    :name => "pineapple",
    :price_per_lb => 2.61,
    :description => "Pineapples are an excellent artifact of previous language. The -apple in their name used to simply mean fruit. Fruit took its place due to the influence of French however apple and pineapple still retain the old name.",
    :display_url => "pine.jpg",
  }, {
    :name => "peach",
    :price_per_lb => 0.99,
    :description => "Fossil endocarps with characteristics indistinguishable from those of modern peaches have been recovered from late Pliocene deposits in Kunming, dating to 2.6 million years ago. In the absence of evidence that the plants were in other ways identical to the modern peach, the name Prunus kunmingensis has been assigned to these fossils.",
    :display_url => "peac.jpg",
  }, {
    :name => "mango",
    :price_per_lb => 2.43,
    :description => "Mangoes are generally sweet, although the taste and texture of the flesh varies across cultivars; some have a soft, pulpy texture similar to an overripe plum, while others are firmer, like a cantaloupe or avocado, and some may have a fibrous texture.",
    :display_url => "mang.jpg",
  }, {
    :name => "grapes",
    :price_per_lb => 2.87,
    :description => "The cultivation of the domesticated grape began 6,000–8,000 years ago in the Near East. Yeast, one of the earliest domesticated microorganisms, occurs naturally on the skins of grapes, leading to the discovery of alcoholic drinks such as wine. The earliest archeological evidence for a dominant position of wine-making in human culture dates from 8,000 years ago in Georgia.",
    :display_url => "grap.jpg",
  }
]

SEEDED_FRUITS.each do |fruit|
  Fruit.create!(fruit)
end

puts 'Seed successful.'