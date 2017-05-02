require 'test_helper'
require 'RPG-Simulator'

describe RPGSimulator do
	let(:bd)  { 'combatants.txt' }
	let(:separateur)  { CombatantTexte::SEPARATEUR }

	describe "creer_monstre" do
		it "cree un nouveau monstre" do
			monstre = RPGSimulator.creer_monstre([], "Morglub")

			monstre.must_equal Combatant.new("Morglub", "MONSTRE", 1, "")
		end

		it "retourne un nouveau monstre si un hero porte le meme nom" do
			hero = Combatant.new("Morglub", "HERO", 1, "")
			monstre = RPGSimulator.creer_monstre([hero], "Morglub")

			monstre.must_equal Combatant.new("Morglub", "MONSTRE", 1, "")
		end

        it "retourne nil si le nom existe deja" do
        	monstre_existant = Combatant.new("Morglub", "MONSTRE", 1, "")
        	monstre = RPGSimulator.creer_monstre([monstre_existant], "Morglub")

        	monstre.must_be_nil
	    end

        it "signale une erreur lorsque le nom est nil" do
        	lambda { RPGSimulator.creer_monstre([], nil) }.must_raise DBC::Failure
	    end

		context "niveau specifie en option" do
	    	it "signale une erreur lorsque le niveau est invalide" do
				lambda { RPGSimulator.creer_monstre([], "Morglub", "a") }.must_raise DBC::Failure
	    	end

			it "signale une erreur lorsque le niveau est plus petit que 1" do
				lambda { RPGSimulator.creer_monstre([], "Morglub", 0) }.must_raise DBC::Failure
	    	end

	    	it "signale une erreur lorsque le niveau est plus grand que 20" do
	      		lambda { RPGSimulator.creer_monstre([], "Morglub", 21) }.must_raise DBC::Failure
	    	end

	      	it "ajoute un monstre si le monstre avec le niveau specifie" do
	      		monstre = RPGSimulator.creer_monstre([], "Morglub", 2)

		        monstre.must_equal Combatant.new("Morglub", "MONSTRE", 2, "")
	        end
    	end     	
	end
end
