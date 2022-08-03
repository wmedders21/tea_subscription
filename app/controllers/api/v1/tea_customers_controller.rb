class Api::V1::TeaCustomersController < ApplicationController
  def create
    customer = Customer.find_by(id: subscription_params[:customer_id])
    tea = Tea.find_by(id: subscription_params[:tea_id])
    subscription = TeaCustomer.create(title: "#{tea.title} Subscription", customer_id: customer.id, tea_id: tea.id)
    render json: TeaCustomerSerializer.new(subscription), status: 201
  end


  private

  def subscription_params
    params.permit(:customer_id, :tea_id)
  end
end
