module ControllerHelpers
  def json_response
    @json_response ||= ControllerHelpers.calculate_json_response(JSON.parse(response.body))
  end

  def self.calculate_json_response(item)
    case item
    when Array
      item.map! { |i| calculate_json_response(i) }
    when Hash
      RecursiveOpenStruct.new(item)
    else
      item
    end
  end
end
