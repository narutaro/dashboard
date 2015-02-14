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


history_db = YAML::Store.new "history.db"
location_db = YAML::Store.new "location.db"


get '/' do
  erb :index
end

get '/stats' do
  content_type :json, :charset => 'utf-8'
  status = Sensor.group("status").count
  status.to_json(:root => false)
end

get '/history' do
  today = Time.now.strftime "%Y-%m-%d"
  stats_today = Sensor.group("status").count
  history_db.transaction do
    history_db[today] = stats_today
  end
  history = history_db.transaction do history_db end
  content_type :json, :charset => 'utf-8'
  history.to_json(:root => false)
end

get '/map' do
  map = location_db.transaction(true) do
    location_db
  end
  content_type :json, :charset => 'utf-8'
  map.to_json(:root => false)
end
