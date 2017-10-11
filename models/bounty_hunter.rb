require("pg")
class Bounty
attr_accessor :name, :species, :bounty_value, :danger_level
attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @species = options["species"]
    @bounty_value = options["bounty_value"].to_i()
    @danger_level = options["danger_level"].to_i()
  end

  def save
    db = PG.connect({
      dbname: "bounty_hunter",
      host: "localhost"
    })
    sql = "INSERT INTO bounties(name, species, bounty_value, danger_level)
    VALUES($1, $2, $3, $4)
    RETURNING id
    "
    values = [@name, @species, @bounty_value, @danger_level]
    db.prepare("save_order", sql)
      @id = db.exec_prepared("save_order", values)[0]["id"].to_i()
    db.close()
  end

  def self.all()
    db = PG.connect({
      dbname: "bounty_hunter",
      host: "localhost"
      })
      sql = "SELECT * FROM bounties"
      values = []
      db.prepare("all", sql)
      bounties = db.exec_prepared("all", values)
      db.close()

      bounties_as_objects = bounties.map{ |bounty| Bounty.new(bounty)}
      return bounties_as_objects
  end

  def update()
      db = PG.connect({
      dbname: "bounty_hunter",
        host: "localhost"
        })
        sql = "UPDATE bounties
                SET (name, species, bounty_value, danger_level) = ($1, $2, $3, $4)
                WHERE id = $5
        "
        values = [@name, @species, @bounty_value, @danger_level, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close()
    end

    def delete()
    db = PG.connect({
      dbname: "bounty_hunter",
      host: "localhost"
      })
      sql = "DELETE FROM bounties WHERE id = $1"
      values = [@id]
      db.prepare("delete_one", sql)
      db.exec_prepared("delete_one", values)
      db.close()
  end

  def self.delete_all
    db = PG.connect({
    dbname: "bounty_hunter",
    host: "localhost"
    })
    sql = "DELETE FROM bounties"
    values = []
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all", values)
    db.close()
  end

  def Bounty.find(id)
    db = PG.connect({
      dbname: "bounty_hunter",
      host: "localhost"
      })
      sql = "SELECT * FROM bounties WHERE id = $1"
      values = [id]
      db.prepare("find", sql)
      bounties_array = db.exec_prepared("find", values)
      bounties_hash = bounties_array[0]
      bounty = Bounty.new(bounties_hash)
      return bounty
      db.close()
  end

end
