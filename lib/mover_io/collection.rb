module MoverIO
  class Collection
    attr_accessor :connector, :id, :name, :writable, :parent_id, :contents

    def initialize(connector, attr)
      self.connector = connector
      self.attributes = attr
    end

    def attributes=(hash)
      self.id = hash["id"]
      self.name = hash["name"]
      self.writable = hash["writable"]
      self.parent_id = hash["parent_id"]
      self.contents = hash["contents"]
    end

    def new_record?
      !id.nil?
    end

    def ==(other)
      other.connector == connector &&
        other.id == id &&
        other.name == name &&
        other.writable == writable &&
        other.parent_id == parent_id
    end
  end

  class CollectionAssociation < Struct.new(:connector)
    def root
      res = connector.get("/collections")
      if res
        Collection.new(connector, res)
      else
        nil
      end
    end

    def find(id)
      res = connector.get("/collection/#{id}")
      if res
        Collection.new(connector, res)
      else
        nil
      end
    end

    def create
      res = connector.post("/collections", {:name => name, :parent_id => collection_id})
      if res
        Collection.new(connector, res)
      else
        false
      end
    end
  end

end

