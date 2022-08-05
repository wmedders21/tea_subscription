require 'rails_helper'

RSpec.describe 'new subscription endpoint' do
  it 'happy path: returns info about the subscription and a 201 status' do
    customer = Customer.create(first_name: 'Patches', last_name: 'McCloud', email: 'pmccloud@test.com', address: '123 Easy Street')
    tea = Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
    body = { tea_id: tea.id }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/customers/#{customer.id}/teas", headers: headers, params: JSON.generate(body)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)

    expect(response_body).to have_key(:data)
    expect(response_body[:data]).to be_a(Hash)

    expect(response_body[:data]).to have_key(:id)
    expect(response_body[:data][:id]).to be_a(String)

    expect(response_body[:data]).to have_key(:type)
    expect(response_body[:data][:type]).to eq('subscription')

    expect(response_body[:data]).to have_key(:attributes)
    expect(response_body[:data][:attributes]).to be_a(Hash)

    expect(response_body[:data][:attributes]).to have_key(:title)
    expect(response_body[:data][:attributes][:title]).to eq('Rooibus Subscription')

    expect(response_body[:data][:attributes]).to have_key(:price)
    expect(response_body[:data][:attributes][:price]).to eq(2000)

    expect(response_body[:data][:attributes]).to have_key(:status)
    expect(response_body[:data][:attributes][:status]).to eq('active')

    expect(response_body[:data][:attributes]).to have_key(:frequency)
    expect(response_body[:data][:attributes][:frequency]).to eq('monthly')
  end

  it 'sad path: invalid tea id' do
    customer = Customer.create(first_name: 'Patches', last_name: 'McCloud', email: 'pmccloud@test.com', address: '123 Easy Street')
    tea = Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
    body = { tea_id: 999999 }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/customers/#{customer.id}/teas", headers: headers, params: JSON.generate(body)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(response_body).to have_key(:error)
    expect(response_body[:error]).to eq('Tea not found')
  end
end
