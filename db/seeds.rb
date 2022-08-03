# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
TeaCustomer.destroy_all
Customer.destroy_all
Tea.destroy_all

Tea.create(title: 'Earl Grey', description: 'Black tea with essence of bergamot', temperature: 200, brew_time: '2 minutes')
Tea.create(title: 'Irish Breakfast', description: 'Black tea. Great with cream', temperature: 200, brew_time: '3 minutes')
Tea.create(title: 'Peppermint', description: 'Excellent herbal tea', temperature: 195, brew_time: '7 minutes')
Tea.create(title: 'Sleepy Time', description: 'Contains chamomile for a relaxed feeling', temperature: 195, brew_time: '10 minutes')
Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
Tea.create(title: 'Gyokuro', description: 'Delicate green tea', temperature: 140, brew_time: '2 minutes')

Customer.create(first_name: 'Bill', last_name: 'Mitchell', email: 'bmitchell@test.com', address: '123 Easy Street, Stomach, TX')
Customer.create(first_name: 'Harley', last_name: 'Jarvis', email: 'hjarvis@test.com', address: '312 Skid Row, Hollywood, CA')

teas = Tea.all
customers = Customer.all

customers.each do |customer|
  tea = teas.sample
  customer.tea_customers.create(title: "#{tea.title} Subscription", price: 1234, tea_id: tea.id)
end
