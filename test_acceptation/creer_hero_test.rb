require 'RPG-Simulator'
require "test_helper.rb"

describe RPGSimulator do
	describe "creer_hero" do
		let(:bd) { "combatants.txt" }
		
		it "creer un nouveau hero avec un niveau specifique" do
        	nouveau_contenu = avec_fichier bd, [], :conserver do
          		genere_sortie(["Hero cree"]) do
            		rpg( "creer_hero --niveau=5 Ben" )
          		end
        	end

        	nouveau_contenu.size.must_equal 1
        	nouveau_contenu.first.must_equal ["Ben", "HERO", 5, [], CombatantTexte::VIVANT].join(CombatantTexte::SEP)

        	FileUtils.rm_f bd
      	end
	end
end