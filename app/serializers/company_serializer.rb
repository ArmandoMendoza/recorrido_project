class CompanySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
