require "rubygems"
require "active_record"
require "yaml"

config = YAML.load_file( './database.yml' )
ActiveRecord::Base.establish_connection(config["db"]["development"])

class Sensor < ActiveRecord::Base
  self.table_name = 'sensor_data_sensor'
end

#Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")

#p Sensor.all

#p Sensor.select(status, count(status))#.group("status")

p Sensor.group("status").count
