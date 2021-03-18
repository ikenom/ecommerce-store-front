# frozen_string_literal: true

require "graphql/client"
require "graphql/client/http"

RSpec.describe CreateVendorJob, :vcr, type: :job do
  let(:vendor_attributes) { build(:vendor).attributes.to_h }
  let(:user) { create(:user) }

  subject(:perform) do
    described_class.perform_now(user: user, **vendor_attributes.deep_transform_keys(&:to_sym))
  end

  it "should have correct queue name" do
    expect(described_class.queue_name).to eq("ecsf_create_vendor")
  end

  it "should create new vendor" do
    expect { perform }.to change { Vendor.count }.by(1)
  end

  it "should return vendor" do
    result = perform
    expect(result).to eq(Vendor.last)
  end
end
