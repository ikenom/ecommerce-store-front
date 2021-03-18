class CreateVendorJob < ApplicationJob
  queue_as :ecsf_create_vendor

  def perform(**attributes)
    Vendor.create!(**attributes)
  end

  private

  def display_name(first_name, last_name)
    "#{first_name} #{last_name}"
  end
end