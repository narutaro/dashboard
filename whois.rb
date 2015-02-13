require "whois"

require 'whois'
#r = Whois.query "google.it"
r = Whois.lookup "ntti3.com"
p r.registrant_contact.organization
# => "Google Ireland Holdings"
