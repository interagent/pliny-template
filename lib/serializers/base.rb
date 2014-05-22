class Serializers
  class Base
    @@structures = {}

    def self.structure(type, &blk)
      @@structures["#{self.name}::#{type}"] = blk
    end

    def initialize(type)
      @type = type
    end

    def serialize(object)
      if object.is_a?(Array)
        object.map do |item|
          serialize_item(item, @type)
        end
      else
        serialize_item(object, @type)
      end
    end

    private

    def serialize_item(item, type)
      @@structures["#{self.name}::#{type}"].call(item)
    end
  end
end
