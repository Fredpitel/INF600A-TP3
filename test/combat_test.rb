require 'test_helper'
require 'RPG-Simulator'

describe RPGSimulator do	
	describe "combat" do
		it "simule un combat entre un hero et un monstre de meme niveau" do
			hero = Combatant.new("Fred", "HERO", 1, "")
			monstre = Combatant.new("Morglub", "MONSTRE", 1, "")
			resultat = RPGSimulator.combat([hero, monstre], "Fred", "Morglub")

			resultat.must_equal "Combat termine, le gagnant est: Fred"
		end

		it "simule un combat entre un hero et un monstre de niveau inferieur" do
			hero = Combatant.new("Fred", "HERO", 2, "")
			monstre = Combatant.new("Morglub", "MONSTRE", 1, "")
			resultat = RPGSimulator.combat([hero, monstre], "Fred", "Morglub")

			resultat.must_equal "Combat termine, le gagnant est: Fred"
		end

		it "simule un combat entre hero et monstre de niveau superieur" do
			hero = Combatant.new("Fred", "HERO", 1, "")
			monstre = Combatant.new("Morglub", "MONSTRE", 2, "")
			resultat = RPGSimulator.combat([hero, monstre], "Fred", "Morglub")

			resultat.must_equal "Combat termine, le gagnant est: Morglub"
		end
    
    	context "option avancee" do
			it "simule un combat entre un hero et un monstre de meme niveau" do
				hero = Combatant.new("Fred", "HERO", 1, "")
				monstre = Combatant.new("Morglub", "MONSTRE", 1, "")

				RPGSimulator.stub :rand, 0 do
					resultat = RPGSimulator.combat([hero, monstre], "Fred", "Morglub", true)
					
					resultat.must_equal "Combat termine, le gagnant est: Morglub"
				end
			end

			it "simule un combat entre un hero et un monstre de niveau tres different et le hero gagne" do
				hero = Combatant.new("Fred", "HERO", 1, "")
				monstre = Combatant.new("Morglub", "MONSTRE", 20, "")

				RPGSimulator.stub :rand, 0 do
					resultat = RPGSimulator.combat([hero, monstre], "Fred", "Morglub", true)
					
					resultat.must_equal "Combat termine, le gagnant est: Fred"
				end
			end

			it "simule un combat entre un hero et un monstre de niveau tres different et le hero perd" do
				hero = Combatant.new("Fred", "HERO", 1, "")
				monstre = Combatant.new("Morglub", "MONSTRE", 20, "")

				RPGSimulator.stub :rand, 1 do
					resultat = RPGSimulator.combat([hero, monstre], "Fred", "Morglub", true)
					
					resultat.must_equal "Combat termine, le gagnant est: Morglub"
				end
			end
		end
    end
end