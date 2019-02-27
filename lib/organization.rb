require 'record'

ORGANIZATION = [ :_id, :url, :external_id, :name, :domain_names, :created_at, :details, :shared_tickets, :tags ]

class Organization < Record
  @expected_fields = ORGANIZATION
  attr_accessor *ORGANIZATION

  def initialize(org) 
    super
    # TODO test that extraneous fields are ignored, and missing ones get set to null
  end
end
