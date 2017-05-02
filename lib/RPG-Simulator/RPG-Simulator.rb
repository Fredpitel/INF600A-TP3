module RPGSimulator
	def self.creer_hero(combatants, nom, niveau = 1)
		creer_combatant(combatants, nom, "HERO", niveau)
	end

	def self.creer_monstre(combatants, nom, niveau = 1)
		creer_combatant(combatants, nom, "MONSTRE", niveau)
	end

	def self.combat(combatants, nom_hero, nom_monstre, avance = false)
		hero = trouver_combatant(combatants, nom_hero, "HERO")
		monstre = trouver_combatant(combatants, nom_monstre, "MONSTRE")

		return "Aucun hero vivant nomme #{nom_hero}" unless hero
		return "Aucun monstre vivant nomme #{nom_monstre}" unless monstre

		plus_fort = hero.niveau >= monstre.niveau ? hero : monstre
		
		if avance
			diff = (hero.niveau - monstre.niveau).abs + 1
			resultat = rand(0..diff)
			if resultat == 0
				gagnant = plus_fort == hero ? monstre : hero
			else
				gagnant = plus_fort
			end
		else
			gagnant = plus_fort
		end

		gerer_victoire(gagnant, hero, monstre)

		"Combat termine, le gagnant est: #{gagnant.nom}"
	end

	def self.lister(combatants, tous = false)
		liste = tous ? combatants : combatants.select { |c| c.vivant? }
		liste.map { |c| c.to_s }.join("\n") 
	end

	def self.creer_combatant(combatants, nom, type, niveau)
		combatants.any? { |c| c.nom == nom && c.type == type } ? nil : Combatant.new(nom, type, niveau, "")
	end

	def self.trouver_combatant(combatants, nom, type)
		combatants.find { |c| c.nom == nom && c.type == type && c.vivant? }
	end

	def self.gerer_victoire(gagnant, hero, monstre)
		perdant = gagnant == hero ? monstre : hero

		gagnant.victimes << perdant.nom
		gagnant.niveau += 1
		perdant.vivant = false
	end
end