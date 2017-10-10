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

end
