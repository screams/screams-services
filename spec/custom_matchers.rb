require 'rspec/expectations'

RSpec::Matchers.define :be_a_success_response do
  match do |json|
    json["success"].present? and json["success"].to_s == '1'
  end
end

RSpec::Matchers.define :be_a_failure_response do
  match do |json|
    json["success"].present? and json["success"].to_s == '0'
  end
end

RSpec::Matchers.define :have_errors do
  match do |json|
    json["errors"].present? and !json["errors"].empty?
  end
end

RSpec::Matchers.define :have_empty do |key|  
  match do |json|
    key.to_s
    json.symbolize_keys
    json[key].nil? or json[key].empty?
  end
end