class Api::V1::TeaCustomersController < ApplicationController
  before_action :verify_customer
  before_action :verify_tea, only: :create

  def index
    customer = Customer.find_by(id: params[:customer_id])
    subscriptions = customer.tea_customers
    render json: TeaCustomerSerializer.new(subscriptions), status: 200
  end

  def create
    customer = Customer.find_by(id: subscription_params[:customer_id])
    tea = Tea.find_by(id: subscription_params[:tea_id])
    subscription = TeaCustomer.create(title: "#{tea.title} Subscription", customer_id: customer.id, tea_id: tea.id)
    render json: TeaCustomerSerializer.new(subscription), status: 201
  end

  def update
    customer = Customer.find_by(id: cancellation_params[:customer_id])
    subscription = customer.tea_customers.find_by(tea_id: cancellation_params[:id])
    subscription.update(status: cancellation_params[:status])
    render json: TeaCustomerSerializer.new(subscription), status: 200
  end


  private

  def subscription_params
    params.permit(:customer_id, :tea_id)
  end

  def cancellation_params
    params.permit(:customer_id, :id, :status)
  end

  def verify_customer
    unless Customer.find_by(id: params[:customer_id])
      render json: { error: 'Customer not found'}, status: 400
    end
  end

  def verify_tea
    unless Tea.find_by(id: subscription_params[:tea_id])
      render json: { error: 'Tea not found'}, status: 400
    end
  end
end
