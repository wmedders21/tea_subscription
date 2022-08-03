require 'rails_helper'

RSpec.describe 'new subscription endpoint' do
  it 'happy path: returns info about the subscription and a 201 status' do
    customer = Customer.create(first_name: 'Patches', last_name: 'McCloud', email: 'pmccloud@test.com', address: '123 Easy Street')
    tea = Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
    body = { tea_id: tea.id }

    post "/customers/#{customer.id}/teas", headers: headers, params: JSON.generate(body)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(response_body).to have_key(:data)
  end
end
