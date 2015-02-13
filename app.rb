require 'sinatra'
require "rubygems"
require "active_record"
require "yaml"
require "yaml/store"

config = YAML.load_file( './database.yml' )
ActiveRecord::Base.establish_connection(config["db"]["development"])

class Sensor < ActiveRecord::Base
  self.table_name = 'sensor_data_sensor'
end

today = Time.now.strftime "%Y-%m-%d"
stats_today = Sensor.group("status").count

db = YAML::Store.new "yaml.db"

db.transaction do
  db[today] = stats_today
end

get '/' do
  erb :index
end

get '/stats' do
  content_type :json, :charset => 'utf-8'
  status = Sensor.group("status").count
  status.to_json(:root => false)
end

get '/history' do
  content_type :json, :charset => 'utf-8'
  history = db.transaction do db end
  history.to_json(:root => false)
end
