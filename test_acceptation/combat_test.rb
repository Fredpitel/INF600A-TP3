require 'RPG-Simulator'
require "test_helper.rb"

describe RPGSimulator do
  	describe "combat" do
  		let(:bd) { "combatants.txt" }
  		let(:combatants) { ["Fred,HERO,1,,VIVANT", "Morglub,MONSTRE,1,,VIVANT"]}

  		it "Simule un combat entre un hero et monstre de meme niveau" do
          	avec_fichier bd, combatants, :conserver do
            		genere_sortie(["Combat termine, le gagnant est: Fred"]) do
              		  rpg( "combat Fred Morglub" )
            		end
          	end
        end
  	end
end