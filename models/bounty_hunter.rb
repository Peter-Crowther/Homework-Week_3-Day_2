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
    RETURNING *
    "
    values = [@name, @species, @bounty_value, @danger_level]
    db.prepare("save_order", sql)
      @id = db.exec_prepared("save_order", values)[0]["id"].to_i()
    db.close()
  end

end
