class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :company_id
end
