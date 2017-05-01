require_relative 'dbc'
require_relative 'combatant-texte'

class Combatant
  attr_reader :nom
  attr_reader :type
  attr_accessor :niveau
  attr_accessor :victimes
  attr_accessor :vivant

  def initialize( nom, type, niveau, *victimes, vivant: true )
    DBC.require( !nom.nil?,
                 "Nom vide: #{nom}" )
    DBC.require( type == "HERO" || type == "MONSTRE",
                 "Type invalide, doit etre HERO ou MONSTRE: #{type}" )
    DBC.require( niveau.to_i > 0 && niveau.to_i <= 20,
                 "Niveau invalide: #{niveau}" )
	DBC.require( victimes.each {|v| v.strip.empty? }, 
		           "Nom de victime vide: #{victimes}" )
    DBC.require( vivant.kind_of?(TrueClass) || vivant.kind_of?(FalseClass),
                 "Vivant incorrect, doit etre true ou false: #{vivant}" )

    @nom = nom
  	@type = type
  	@niveau = niveau
  	@victimes = victimes
  	@vivant = vivant
  end

  def vivant?
  	@vivant
  end
end
