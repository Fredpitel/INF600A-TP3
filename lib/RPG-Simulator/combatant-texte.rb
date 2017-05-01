module CombatantTexte
  # Separateur pour les champs d'un enregistrement specificant un combatant.
  SEPARATEUR = ','
  SEP = SEPARATEUR  # Un alias pour alleger les expr. reg.

  # Separateur pour les victimes d'un combatant.
  SEPARATEUR_VICTIMES = ':'

  # Etat d'un combatant
  VIVANT  = 'VIVANT'
  MORT  = 'MORT'

  # Methode pour creer un objet Combatant a partir d'une ligne lue dans la
  # base de donnees.
  def self.creer_combatant( ligne )
    nom, type, niveau, victimes, vivant = ligne.chomp.split(SEP)
    Combatant.new( nom,
    			   type,
               	   niveau.to_i,
               	   *victimes.split(SEPARATEUR_VICTIMES),
               	   vivant: vivant == VIVANT )
  end

  # Methode pour sauvegarder un objet Combatant dans la base de donnees.
  def self.sauver_combatant( fich, cours )
    vivant = combatant.vivant? ? VIVANT : MORT
    victimes = combatant.victimes.join(SEPARATEUR_VICTIMES)
    fich.puts [combatant.nom, combatant.type, combatant.niveau, vivant].join(SEP)
  end
end