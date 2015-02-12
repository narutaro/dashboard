require 'pstore'

db = PStore.new("./psdb")

=begin
db.transaction do
  db['day1'] = [1, 2, 3]
  db['day2'] = [1, 2, 3]
end
=end

db.transaction do
  p db['day1']
  p db['day2']
end

