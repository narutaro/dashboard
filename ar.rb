require "rubygems"
require "active_record"
require "yaml"
require 'yaml/store'

config = YAML.load_file( './database.yml' )
ActiveRecord::Base.establish_connection(config["db"]["development"])

class Sensor < ActiveRecord::Base
  self.table_name = 'sensor_data_sensor'
end

#Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")

#p Sensor.all

#p Sensor.select(status, count(status))#.group("status")

#count = Sensor.group("status").count

t = Time.now.strftime "%Y-%m-%d"

stats_today = Sensor.group("status").count

db = YAML::Store.new "yaml.db"

db.transaction do
  db[t] = stats_today
end

a = db.transaction do
  db
end

p a
