require 'test_helper'
require 'RPG-Simulator'

describe RPGSimulator do
	describe "creer_hero" do
		it "retourne un nouveau hero" do
			hero = RPGSimulator.creer_hero([], "Fred")

			hero.must_equal Combatant.new("Fred", "HERO", 1, "")
		end

		it "retourne un nouveau hero si un monstre porte le meme nom" do
			monstre = Combatant.new("Fred", "MONSTRE", 1, "")
			hero = RPGSimulator.creer_hero([monstre], "Fred")

			hero.must_equal Combatant.new("Fred", "HERO", 1, "")
		end

        it "retourn nil si le nom existe deja" do
        	hero_existant = Combatant.new("Fred", "HERO", 1, "")
        	hero = RPGSimulator.creer_hero([hero_existant], "Fred")

        	hero.must_be_nil
	    end

        it "signale une erreur lorsque le nom est nil" do
        	lambda { RPGSimulator.creer_hero([], nil) }.must_raise DBC::Failure
	    end

		context "niveau specifie en option" do
	    	it "signale une erreur lorsque le niveau est invalide" do
				lambda { RPGSimulator.creer_hero([], "Fred", "a") }.must_raise DBC::Failure
	    	end

			it "signale une erreur lorsque le niveau est plus petit que 1" do
				lambda { RPGSimulator.creer_hero([], "Fred", 0) }.must_raise DBC::Failure
	    	end

	    	it "signale une erreur lorsque le niveau est plus grand que 20" do
	      		lambda { RPGSimulator.creer_hero([], "Fred", 21) }.must_raise DBC::Failure
	    	end

	      	it "ajoute un hero si le hero avec le niveau specifie" do
	      		hero = RPGSimulator.creer_hero([], "Fred", 2)

		        hero.must_equal Combatant.new("Fred", "HERO", 2, "")
	        end
    	end    	
	end
end
