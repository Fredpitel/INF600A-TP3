require 'test_helper'
require 'RPG-Simulator'

describe RPGSimulator do
	let(:bd)  { 'combatants.txt' }
	let(:separateur)  { CombatantTexte::SEPARATEUR }
	let(:separateur_victimes)  { CombatantTexte::SEPARATEUR_VICTIMES }

	describe "combat" do
		it "signale une erreur lorsque depot inexistant" do
      		FileUtils.rm_f bd
      		genere_erreur( /.*PreconditionFailed.*/ ) do
        		rpg( 'combat Fred Morglub' )
      		end
    	end

    	context "Fichier avec plusieurs combatants" do
    		let(:lignes) { IO.readlines("combatants_existants.txt") }

	        it "signale une erreur lorsque le hero est inexistant" do
	        	attendu = ['Aucun hero vivant nomme Ben']
		      	avec_fichier bd, lignes do
		      		genere_sortie( attendu ) do
		        		rpg( 'combat Ben Morglub' )
	      			end
	      		end
		    end

		    it "signale une erreur lorsque le monstre est inexistant" do
	        	attendu = ['Aucun monstre vivant nomme Barlax']
		      	avec_fichier bd, lignes do
		      		genere_sortie( attendu ) do
		        		rpg( 'combat Fred Barlax' )
	      			end
	      		end
		    end

		    it "signale une erreur lorsque le hero est mort" do
	        	attendu = ['Aucun hero vivant nomme Dan']
		      	avec_fichier bd, lignes do
		      		genere_sortie( attendu ) do
		        		rpg( 'combat Dan Morglub' )
	      			end
	      		end
		    end

		    it "signale une erreur lorsque le monstre est mort" do
	        	attendu = ['Aucun monstre vivant nomme Xarglob']
		      	avec_fichier bd, lignes do
		      		genere_sortie( attendu ) do
		        		rpg( 'combat Fred Xarglob' )
	      			end
	      		end
		    end

		    it "simule un combat entre un hero et un monstre" do
		    	attendu = ['Combat termine, le gagnant est: Fred']

		        nouveau_contenu = avec_fichier bd, lignes, :conserver do
		          genere_sortie attendu do
		            rpg( "combat Fred Morglub" )
		          end
		        end

		        nouveau_contenu.find { |l| l =~ /^Fred/ }.must_equal ["Fred", "HERO", 2, "Morglub", CombatantTexte::VIVANT].join(separateur)
	        	nouveau_contenu.find { |l| l =~ /^Morglub/ }.must_equal ["Morglub", "MONSTRE", 1, "", CombatantTexte::MORT].join(separateur)
		        FileUtils.rm_f bd
	        end
	    end
    end
end