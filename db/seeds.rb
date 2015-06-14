# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
slip_no = SlipNo.create({ name: 'slip_no', now_val: 100000, max_val: 999999, min_val: 100001, prefix: 'SH'})  
