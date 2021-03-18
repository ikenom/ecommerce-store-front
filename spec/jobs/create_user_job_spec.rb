# frozen_string_literal: true

require "graphql/client"
require "graphql/client/http"

RSpec.describe CreateUserJob, :vcr, type: :job do
  let(:user_attributes) { build(:user).attributes.to_h }
  let(:password) { Faker::Alphanumeric.alpha }

  subject(:perform) do
    described_class.perform_now(password: password, **user_attributes.deep_transform_keys(&:to_sym))
  end

  it "should have correct queue name" do
    expect(described_class.queue_name).to eq("ecsf_create_user")
  end

  it "should create new user" do
    expect { perform }.to change { User.count }.by(1)
  end

  it "should return hash" do
    result = perform
    expect(result).to include(:token)
    expect(result).to include(:user => User.last)
  end
end
