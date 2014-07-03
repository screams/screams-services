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

RSpec::Matchers.define :be_a_json_of do |to_be_record|
  match do |actual_json|
    actual_hash = actual_json.symbolize_keys!.except!(:created_at, :updated_at)
    to_be_hash = to_be_record.as_json.symbolize_keys!.except!(:created_at, :updated_at)
    to_be_hash == actual_hash
  end
end