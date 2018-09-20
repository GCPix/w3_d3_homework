require('pg')

class SqlRunner
  def self.run(sql, values = [])
    begin #the stuff that can go wrong
      db = PG.connect({dbname: "music_manager", host: "localhost"})
      db.prepare("query_file", sql)
      results = db.exec_prepared("query_file", values)
    ensure #the stuff that must happen regardless of above outcome
      db.close if db != nil
    end
      return results
  end
end
