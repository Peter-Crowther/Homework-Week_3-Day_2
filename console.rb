require("pry-byebug")
require("pry")
require_relative("models/bounty_hunter.rb")

# Bounty.delete_all()
Bounty.find()


bounty_1 = Bounty.new(
  {
    "name" => "Bobo",
    "species" => "Space Weegie",
    "bounty_value" => "4000",
    "danger_level" => "7"
  }
)

bounty_2 = Bounty.new(
  {
    "name" => "Squeege",
    "species" => "Sponger",
    "bounty_value" => "2000",
    "danger_level" => "4"
  }
)

binding.pry
nil
