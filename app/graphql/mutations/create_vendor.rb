module Mutations
  class CreateVendor < BaseMutation
    argument :business_name, String, required: true

    field :vendor, Types::VendorType, null: false

    def resolve(**attributes)
      raise Errors::Unauthorized if context[:current_user].nil?

      user = context[:current_user]
      vendor = Vendor.create!(user: user, **attributes)
      {
        vendor: vendor
      }
    end
  end
end