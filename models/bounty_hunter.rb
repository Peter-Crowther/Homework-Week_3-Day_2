require("pg")
class Bounty
attr_accessor :name, :species, :bounty_value, :danger_level
attr_reader :id

def initialize(bounties)
    @id = bounties["id"].to_i if options["id"]
    @name = bounties["name"]
    @species = bounties["species"]
    @bounty_value = bounties["bounty_value"].to_i()
    @danger_level = bounties["danger_level"].to_i()
  end

end
