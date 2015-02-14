require "rubygems"
require 'yaml/store'


ydb = YAML::Store.new "sensor.db"

aaa = ydb.transaction(true) do
  ydb
end

p aaa
