# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl'
Dir[Rails.root.join("spec/support/*.rb")].each {|f| require f}

FactoryGirl.create :books

Country.create([
                   {name: "Ukraine"},
                   {name: "Russian"}
               ])
State.create([
                 {state: "In progress"},
                 {state: "In queue"},
                 {state: "In delivery"},
                 {state: "Delivered"},
                 {state: "Canceled"}
             ])