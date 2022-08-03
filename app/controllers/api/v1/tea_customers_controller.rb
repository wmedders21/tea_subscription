class Api::V1::TeaCustomersController < ApplicationController

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
end
