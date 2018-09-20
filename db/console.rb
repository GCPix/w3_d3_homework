#require('pg')
require('pry')
require_relative("../models/artist.rb")
require_relative("../models/album.rb")

Album.delete_all()
Artist.delete_all()
artist1 = Artist.new({"name" => "Blondie"})
artist1.save()
artist2 = Artist.new({"name" => "Spice Girls"})
artist2.save()
artist3 = Artist.new({"name" => "Lifehouse"})
artist3.save()
artist4 = Artist.new({"name" => "Ben Folds"})
artist4.save()

album1 = Album.new({
  "title" => "Parallel Lines",
  "genre" => "pop",
  "artist_id" => artist1.id
})
album1.save()
album2 = Album.new({
  "title" => "Spice World",
  "genre" => "pop",
  "artist_id" => artist2.id
})
album2.save()
album3 = Album.new({
  "title" => "No Name Face",
  "genre" => "rock",
  "artist_id" => artist3.id
})
album3.save()
artist4.name = 'Ben Folds 5'

artist4.update()

album1.genre = "punk"
album1.update()



binding.pry
nil
