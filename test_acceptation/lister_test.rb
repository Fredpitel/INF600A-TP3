require 'RPG-Simulator'
require "test_helper.rb"

describe RPGSimulator do
  	describe "lister" do
    		let(:bd) { "combatants.txt" }
    		let(:combatants) { ["Fred,HERO,2,Xarluf,VIVANT", "Morglub,MONSTRE,1,,VIVANT", "Xarluf,MONSTRE,1,,MORT"]}

    		it "creer un nouveau hero avec un niveau specifique" do
    	      attendu = ['Fred, HERO, 2, ["Xarluf"]',
                       'Morglub, MONSTRE, 1, []',
                       'Xarluf(RIP), MONSTRE, 1, []'
                      ]

            avec_fichier bd, combatants, :conserver do
            		genere_sortie(attendu) do
              		  rpg( "lister --tous" )
            		end
          	end

            FileUtils.rm_f bd
    	  end
  	end
end