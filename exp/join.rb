require "rubygems"
require "active_record"
require "yaml"
require 'yaml/store'

config = YAML.load_file( '../database.yml' )
ActiveRecord::Base.establish_connection(config["db"]["development"])

class Sensor < ActiveRecord::Base
  self.table_name = 'sensor_data_sensor'
  belongs_to :Location, :foreign_key => 'location_id'
end

class Location < ActiveRecord::Base
  self.table_name = 'sensor_data_location'
  has_many :Sensor
end

#p Sensor.find_by_sql("SELECT `csp`.`sensor_data_location` FROM `dev_me`.`sensor_data_sensor` INNER JOIN  `dev_me`.`sensor_data_location` ON `sensor_data_sensor`.`location_id` = `sensor_data_location`.`id`;")
#p Sensor.all
#p Location.all
#p Location.find(82).Sensor
#Location.find(82).Sensor.each do |s|
#  p s
#end

Location.select('csp').each do |csp|
 p csp
end


#Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")
#p Sensor.all
#p Sensor.select(status, count(status))#.group("status")
#count = Sensor.group("status").count

