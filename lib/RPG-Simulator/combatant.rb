require_relative 'dbc'
require_relative 'combatant-texte'

module Combatant
  attr_reader :nom
  attr_reader :type
  attr_reader :niveau
  attr_reader :victimes
  attr_accessor :vivant

  def initialize( nom, type, niveau, *victimes, vivant: true )
    DBC.require( !nom..strip.empty?,
                 "Nom vide: #{nom}" )
    DBC.require( !titre.strip.empty?,
                 "Titre vide: '#{titre}'" )
    DBC.require( niveau.to_i > 0 && niveau <= 20,
                 "Niveau invalide: #{niveau}" )
	  DBC.require( victimes.each {|v| v.strip.empty? }, 
				         "Nom de victime vide: #{v}" )
    DBC.require( vivant.kind_of?(TrueClass) || vivant.kind_of?(FalseClass),
                 "Vivant incorrect, doit etre true ou false: #{vivant}" )

    @sigle, @titre, @nb_credits, @prealables, @actif = sigle, titre, nb_credits, prealables, actif
  end
end
