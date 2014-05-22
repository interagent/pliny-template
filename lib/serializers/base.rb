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
      @@structures["#{self.class.name}::#{@type}"].call(object)
    end
  end
end
