require 'test_helper'
require 'RPG-Simulator'

describe RPGSimulator do
	let(:bd)  { 'combatants.txt' }
	let(:separateur)  { CombatantTexte::SEPARATEUR }

	describe "creer_hero" do
		it "cree un nouveau hero dans un fichier vide" do
			attendu = ['Hero cree']
			nouveau_contenu = avec_fichier bd, [], :conserver do
        		genere_sortie attendu do
          			rpg( "creer_hero Fred")
        		end
      		end

			nouveau_contenu.size.must_equal 1
			nouveau_contenu.first.must_equal ["Fred", "HERO", 1, "", CombatantTexte::VIVANT].join(separateur)
			FileUtils.rm_f bd
		end
		
		it "signale une erreur lorsque depot inexistant" do
      		FileUtils.rm_f bd
      		genere_erreur( /.*PreconditionFailed.*/ ) do
        		rpg( 'creer_hero Fred' )
      		end
    	end

        it "signale une erreur lorsque le nom est vide" do
	      	avec_fichier bd, [] do
	      		genere_erreur( /.*Precondition non satisfaite: Nom vide:*/ ) do
	        		rpg( 'creer_hero' )
      			end
      		end
	    end

		context "Fichier avec plusieurs combatants" do
      		let(:lignes) { IO.readlines("combatants_existants.txt") }

	      	it "ajoute un hero si le nom est unique" do
	      		attendu = ["Hero cree"]
		        nouveau_contenu = avec_fichier bd, lignes, :conserver do
		          genere_sortie attendu do
		            rpg( "creer_hero Max" )
		          end
		        end

		        nouveau_contenu.last
		          .must_equal ["Max", "HERO", 1, "", CombatantTexte::VIVANT].join(separateur)

		        FileUtils.rm_f bd
	        end

	        it "ajoute un hero si le nom utilise par un monstre" do
	      		attendu = ["Hero cree"]
		        nouveau_contenu = avec_fichier bd, lignes, :conserver do
		          genere_sortie attendu do
		            rpg( "creer_hero Morglub" )
		          end
		        end

		        nouveau_contenu.last
		          .must_equal ["Morglub", "HERO", 1, "", CombatantTexte::VIVANT].join(separateur)

		        FileUtils.rm_f bd
	        end

	        it "signale une erreur lorsque le nom est utilise" do
			    avec_fichier bd, lignes do
			      	genere_erreur( /Un hero avec ce nom existe deja.*/ ) do
			        	rpg( 'creer_hero Fred' )
		      		end
			    end
		    end
	    end
	    	
		context "fichier de base de donnees autre que celui par defaut" do
    		let(:lignes) { IO.readlines("combatants_existants.txt") }
    		let(:fichier) { 'nouveau_fichier.txt' }

			it "signale une erreur lorsque depot inexistant" do
	      		FileUtils.rm_f fichier
	      		genere_erreur( /.*PreconditionFailed.*/ ) do
	        		rpg( '--depot=#{fichier} creer_hero Fred' )
	      		end
	    	end

	      	it "ajoute un hero si le nom est unique" do
	      		attendu = ["Hero cree"]
		        nouveau_contenu = avec_fichier fichier, lignes, :conserver do
		          genere_sortie attendu do
		            rpg( "--depot=#{fichier} creer_hero Max" )
		          end
		        end

		        nouveau_contenu.last
		          .must_equal ["Max", "HERO", 1, "", CombatantTexte::VIVANT].join(separateur)

		        FileUtils.rm_f fichier
	        end
    	end

		context "niveau specifie en option" do
	    	it "signale une erreur lorsque le niveau est invalide" do
				avec_fichier bd, [] do
		      		genere_erreur( /.*Precondition non satisfaite: Niveau invalide:*/ ) do
		        		rpg( 'creer_hero --niveau=a Max' )
		      		end
	      		end
	    	end

			it "signale une erreur lorsque le niveau est plus petit que 1" do
				avec_fichier bd, [] do
		      		genere_erreur( /.*Precondition non satisfaite: Niveau invalide:*/ ) do
		        		rpg( 'creer_hero --niveau=0 Max' )
		      		end
	      		end
	    	end

	    	it "signale une erreur lorsque le niveau est plus grand que 20" do
				avec_fichier bd, [] do
		      		genere_erreur( /.*Precondition non satisfaite: Niveau invalide:*/ ) do
		        		rpg( 'creer_hero --niveau=21 Max' )
		      		end
	      		end
	    	end

	      	it "ajoute un hero si le hero avec le niveau specifie" do
	      		attendu = ["Hero cree"]
		        nouveau_contenu = avec_fichier bd, [], :conserver do
		          genere_sortie attendu do
		            rpg( "creer_hero --niveau=2 Max" )
		          end
		        end

		        nouveau_contenu.last
		          .must_equal ["Max", "HERO", 2, "", CombatantTexte::VIVANT].join(separateur)

		        FileUtils.rm_f bd
	        end
    	end    	
	end
end
