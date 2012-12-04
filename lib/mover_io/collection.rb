module MoverIO
  class Collection < Struct.new(:connector, :id, :name, :writable, :parent_id, :contents)
    def new_record?
      !id.nil?
    end
  end

  class CollectionAssociation < Struct.new(:connector)
    def root
      res = connector.get("/collections")
      if res
        Collection.new(connector,
                       res["id"],
                       res["name"],
                       res["writable"],
                       res["parent_id"],
                       res["contents"]
                      )
      else
        nil
      end
    end

    def find(id)
      res = connector.get("/collection/#{id}")
      if res
        Collection.new(connector,
                       res["id"],
                       res["name"],
                       res["writable"],
                       res["parent_id"],
                       res["contents"]
                      )
      else
        nil
      end
    end

    def create
      res = connector.post("/collections", {:name => name, :parent_id => collection_id})
      if res
        Collection.new(connector,
                       res["id"],
                       res["name"],
                       res["writable"],
                       res["parent_id"],
                       res["contents"]
                      )
      else
        false
      end
    end
  end

end

