class TeaCustomerSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency
  set_type :subscription
end
