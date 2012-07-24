class State < ActiveRecord::Base
  belongs_to :country, :foreign_key => 'country_numcode'

  validates :country, :name, :presence => true

  attr_accessible :name, :abbr

  def self.find_all_by_name_or_abbr(name_or_abbr)
    where('name = ? OR abbr = ?', name_or_abbr, name_or_abbr)
  end

  # table of { country.id => [ state.id , state.name ] }, arrays sorted by name
  # blank is added elsewhere, if needed
  def self.states_group_by_country_numcode
    state_info = Hash.new { |h, k| h[k] = [] }
    State.order('name ASC').each { |state| state_info[state.country_numcode.to_s].push [state.id, state.name]}
    state_info
  end

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
  
end

# == Schema Information
#
# Table name: states
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  abbr            :string(255)
#  country_numcode :integer
#  name_ascii      :string(255)
#

