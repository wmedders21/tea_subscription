require 'rails_helper'

RSpec.describe 'a customers subscriptions endpoint' do
  it 'happy path: returns info about all the customers subscriptions and a 200 status' do
    customer = Customer.create(first_name: 'Patches', last_name: 'McCloud', email: 'pmccloud@test.com', address: '123 Easy Street')
    tea_1 = Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
    tea_2 = Tea.create(title: 'Irish Breakfast', description: 'Black tea. Great with cream', temperature: 200, brew_time: '3 minutes')
    TeaCustomer.create(title: "#{tea_1.title} Subscription", customer_id: customer.id, tea_id: tea_1.id)
    TeaCustomer.create(title: "#{tea_2.title} Subscription", customer_id: customer.id, tea_id: tea_2.id, status: 1)

    get "/api/v1/customers/#{customer.id}/teas"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)

    expect(response_body).to have_key(:data)
    expect(response_body[:data]).to be_a(Array)

    response_body[:data].each do |element|
      expect(element).to have_key(:id)
      expect(element[:id]).to be_a(String)

      expect(element).to have_key(:type)
      expect(element[:type]).to eq('subscription')

      expect(element).to have_key(:attributes)
      expect(element[:attributes]).to be_a(Hash)

      expect(element[:attributes]).to have_key(:title)
      expect(element[:attributes][:title]).to be_a(String)

      expect(element[:attributes]).to have_key(:price)
      expect(element[:attributes][:price]).to eq(2000)

      expect(element[:attributes]).to have_key(:status)
      expect(element[:attributes][:status]).to be_a(String)

      expect(element[:attributes]).to have_key(:frequency)
      expect(element[:attributes][:frequency]).to be_a(String)
    end
  end
end
