
require('pg')
require_relative('../db/sql_runner')

class Artist
  attr_accessor :id, :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()

    sql = "INSERT INTO artists(name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)

    @id = result[0]["id"].to_i
  end

  def self.find_all()
    sql = "SELECT * FROM artists"

    result = SqlRunner.run(sql)
    artist_list = result.map{|result_hash| Artist.new(result_hash)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE artists SET name = $1  WHERE id = $2"
    values = [@name, @id]

    SqlRunner.run(sql, values)
  end

  def delete_artist()
    sql = "DELETE FROM artists WHERE name = $1"

    values = [@name]

    SqlRunner.run(sql,values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"

    values = [id]

    result = SqlRunner.run(sql, values)

    details = result.map{|result| Artist.new(result)}# result is the returned object from the exec_prepared statement? if it contains multiple rows of data we would need an array to see and use them all, map creates a new array with the details that were return seperated one index per row, the actual detail in this case is a has "id" => 222, "name" => "Lifehouse".  We then take each position in the array and say make it an object which is where Artist.new(result) comes in.

  end

  def find_albums_for_artist
    sql = "SELECT * FROM albums WHERE artist_id = $1"

    values = [@id]

    album_list = SqlRunner.run(sql, values)
    return album_list.map{|album| Album.new(album)}
  end
end
