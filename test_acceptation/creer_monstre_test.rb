require 'RPG-Simulator'
require "test_helper.rb"

describe RPGSimulator do
  	describe "creer_monstre" do
		    let(:bd) { "combatants.txt" }
		
		    it "creer un nouveau monstre avec un niveau specifique" do
        	  nouveau_contenu = avec_fichier bd, [], :conserver do
          		  genere_sortie(["Monstre cree"]) do
            	      rpg( "creer_monstre --niveau=5 Morglub" )
        		    end
        	  end

        	  nouveau_contenu.size.must_equal 1
        	  nouveau_contenu.first.must_equal ["Morglub", "MONSTRE", 5, [], CombatantTexte::VIVANT].join(CombatantTexte::SEP)

        	  FileUtils.rm_f bd
        end
    end
end