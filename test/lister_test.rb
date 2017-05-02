require 'test_helper'
require 'RPG-Simulator'

describe RPGSimulator do
	let(:fred) { Combatant.new("Fred", "HERO", 3, "Xarluf","Mageb") }
	let(:morglub) { Combatant.new("Morglub", "MONSTRE", 1, "") }
	let(:xarluf) { Combatant.new("Xarluf", "MONSTRE", 2, "Ben").tuer }
	let(:mageb) { Combatant.new("Mageb", "MONSTRE", 1, "").tuer }
	let(:ben) { Combatant.new("Ben", "HERO", 1, "").tuer }
	let(:combatants) { [fred, morglub, xarluf, mageb, ben] }

	describe "lister" do
		it "liste les combatants vivants" do
			attendu = ['Fred, HERO, 3, ["Xarluf", "Mageb"]', 'Morglub, MONSTRE, 1, [""]']

		   	resultat = RPGSimulator.lister(combatants).split("\n")
			resultat.must_equal attendu
		end

		it "liste tous les combatants" do
			attendu = ['Fred, HERO, 3, ["Xarluf", "Mageb"]',\
				 	   'Morglub, MONSTRE, 1, [""]',\
				 	   'Xarluf(RIP), MONSTRE, 2, ["Ben"]',\
				 	   'Mageb(RIP), MONSTRE, 1, [""]',\
				 	   'Ben(RIP), HERO, 1, [""]']

		   	resultat = RPGSimulator.lister(combatants, true).split("\n")
			resultat.must_equal attendu
		end

		it "liste rien si aucun combatants" do
			attendu = ""

		   	resultat = RPGSimulator.lister([])
			resultat.must_equal attendu
		end
    end
end