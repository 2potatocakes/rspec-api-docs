module RspecApiDocs
  class RaddocsRenderer
    class ResourceSerializer
      attr_reader :resource

      def initialize(resource)
        @resource = resource
      end

      def to_h
        {
          resource: resource.name,
          resource_explanation: nil,
          http_method: resource.http_method,
          route: resource.path,
          description: resource.example_name,
          explanation: resource.description,
          parameters: resource.parameters,
          response_fields: response_fields(resource.response_fields),
          requests: resource.requests,
        }
      end

      private

      def response_fields(fields)
        fields.map do |field|
          {
            scope: field.scope,
            Type: field.type,
            name: field.name,
            description: field.description,
          }
        end
      end
    end
  end
end
