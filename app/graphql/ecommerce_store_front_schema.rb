class EcommerceStoreFrontSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    case obj
    when User
      Types::UserType
    when DraftOrder
      Types::DraftOrderType
    when Product
      Types::ProductType
    else
      raise(GraphQL::RequiredImplementationMissingError)
    end
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    model = Object.const_get(type_definition.graphql_name).find(id: object.id)
    model.to_global_id
  end

  def self.object_from_id(id, query_ctx)
    GlobalID::Locator.locate id
  end
end
