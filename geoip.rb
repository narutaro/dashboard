require "rubygems"
require 'maxminddb'
require "active_record"
require "yaml"
require 'yaml/store'

geoip_db = MaxMindDB.new('./GeoLite2-City.mmdb')

config = YAML.load_file( './database.yml' )
ActiveRecord::Base.establish_connection(config["db"]["development"])

class Sensor < ActiveRecord::Base
  self.table_name = 'sensor_data_sensor'
end

sensor_location_db = YAML::Store.new "sensor_location.db"

running_sensors = {}
Sensor.where(status: "RUNNING").each do |s|

  out = geoip_db.lookup(s.ip_address)

  # [ {latLng: [41.90, 12.45], name: 'Vatican City'}, {latLng: [43.73, 7.41], name: 'Monaco'} ]
  running_sensors["LatLng"] = [out.location.latitude, out.location.longitude]
  if out.city.name(:fr).nil?
    running_sensors["name"] = [out.country.name]
  else
    running_sensors["name"] = [out.city.name(:fr)]
  end

  #puts "#{s.name}, #{s.ip_address}\t#{s.status}\t#{out.country.name}\t#{out.city.name(:fr)}\t#{out.location.latitude}\t#{out.location.longitude}"
  sensor_location_db.transaction do
    sensor_location_db[s.name] = running_sensors
  end

end


