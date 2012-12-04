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

    def writable?
      !!writable
    end

    def parent
      return nil if parent_id.nil? or parent_id == ""
      connector.find(parent_id)
    end
  end

  class CollectionAssociation < Struct.new(:connector)
    def root
      parse_res connector.get("/collections")
    end

    def find(id)
      parse_res connector.get("/collection/#{id}")
    end

    def create(name, parent_id)
      parse_res connector.post("/collections", {:name => name, :parent_id => parent_id})
    end

    def new(params = {})
      parse_res(params)
    end

    private

    def parse_res(res)
      if res
        Collection.new(connector, res)
      else
        false
      end
    end
  end

end

