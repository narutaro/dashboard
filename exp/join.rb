require "rubygems"
require "active_record"
require "yaml"
require 'yaml/store'

config = YAML.load_file( './database.yml' )
ActiveRecord::Base.establish_connection(config["db"]["development"])

class Sensor < ActiveRecord::Base
  self.table_name = 'sensor_data_sensor'
  belongs_to :sensor_data_location
end

class Location < ActiveRecord::Base
  self.table_name = 'sensor_data_location'
  has_many :sensor_data_sensor
end

#p Sensor.find_by_sql("SELECT `csp`.`sensor_data_location` FROM `dev_me`.`sensor_data_sensor` INNER JOIN  `dev_me`.`sensor_data_location` ON `sensor_data_sensor`.`location_id` = `sensor_data_location`.`id`;")
p Sensor.includes(:sensor_data_location)


#Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")
#p Sensor.all
#p Sensor.select(status, count(status))#.group("status")
#count = Sensor.group("status").count

