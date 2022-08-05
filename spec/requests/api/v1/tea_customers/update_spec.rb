require 'rails_helper'

RSpec.describe 'cancel subscription endpoint' do
  it 'happy path: returns info about the subscription and a 200 status' do
    customer = Customer.create(first_name: 'Patches', last_name: 'McCloud', email: 'pmccloud@test.com', address: '123 Easy Street')
    tea = Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
    TeaCustomer.create(title: "#{tea.title} Subscription", customer_id: customer.id, tea_id: tea.id)
    body = { status: 1 }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/customers/#{customer.id}/teas/#{tea.id}", headers: headers, params: JSON.generate(body)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)

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
    expect(response_body[:data][:attributes][:status]).to eq('cancelled')

    expect(response_body[:data][:attributes]).to have_key(:frequency)
    expect(response_body[:data][:attributes][:frequency]).to eq('monthly')
  end

  it 'sad path: invalid tea id' do
    customer = Customer.create(first_name: 'Patches', last_name: 'McCloud', email: 'pmccloud@test.com', address: '123 Easy Street')
    tea = Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
    TeaCustomer.create(title: "#{tea.title} Subscription", customer_id: customer.id, tea_id: tea.id)
    body = { status: 1 }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/customers/#{customer.id}/teas/99999", headers: headers, params: JSON.generate(body)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(response_body).to have_key(:error)
    expect(response_body[:error]).to eq('Tea not found')
  end

  it 'sad path: invalid customer id' do
    customer = Customer.create(first_name: 'Patches', last_name: 'McCloud', email: 'pmccloud@test.com', address: '123 Easy Street')
    tea = Tea.create(title: 'Rooibus', description: 'Red bush tea from southern Africa', temperature: 212, brew_time: '5 minutes')
    TeaCustomer.create(title: "#{tea.title} Subscription", customer_id: customer.id, tea_id: tea.id)
    body = { status: 1 }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/customers/99999/teas/#{tea.id}", headers: headers, params: JSON.generate(body)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(response_body).to have_key(:error)
    expect(response_body[:error]).to eq('Customer not found')
  end
end
