

require('pg')

require_relative('../db/sql_runner')



class Album
attr_accessor :id, :title, :genre, :artist_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
    @artist_id = options["artist_id"].to_i

  end

  def save()
    sql = "INSERT INTO albums(title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"

    values = [@title,@genre, @artist_id]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def self.find_all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    return results.map{|result_hash| Album.new(result_hash)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def delete_album()
    sql = "DELETE FROM albums WHERE title = $1"
    #to test I am typing in album2.delete_album.  it works but how does this work in real life?
    #when you request details in pry for album2 it still returns the object.  Is this because we are still in the middle of running the console?

    values = [@title]

    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"

    values = [@title, @genre, @artist_id, @id]

    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"

    values = [id]

    result = SqlRunner.run(sql, values)
    return result.map{|result_hash| Album.new(result_hash)}
  end

  def find_artist_for_album()
    sql = "SELECT * FROM artists WHERE id = $1"

    values = [@artist_id] # so the sql query runs using fields from the artists table but as we are in the album class we need to use the @artist_id (which is the same value copied across) to fill in the query

    artist = SqlRunner.run(sql, values)
    results = artist.map{|artist_hash| Artist.new(artist_hash)} #compilation albums have multiple artists, if it just comes back with various I would just do return Artist.new(artist)
  end
end
