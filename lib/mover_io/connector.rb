module MoverIO
  class Connector < Struct.new(:session, :id, :type)
    def new_record?
      !id.nil?
    end

    def save
      raise "Can't update an existing Connector" if new_record?
      res = session.post("/connectors", {'type' => type})
      if res
        self.id = res["id"]
        true
      else
        false
      end
    end

    def get(path, params = {})
      session.get("/connectors/#{id}#{path}", params)
    end

    def post(path, params = {})
      session.post("/connectors/#{id}#{path}", params)
    end

    def collections
      CollectionAssociation.new(self)
    end
  end

  class ConnectorAssociation < Struct.new(:session)
    def available
      session.get("/connectors/available")
    end

    def all
      res = session.get("/connectors")
      if res
        res["connectors"].map{|connector|
          Connector.new(session, connector["id"], connector["type"])
        }
      else
        []
      end
    end

    def new(type)
      Connector.new(session, nil, type)
    end

    def find(id)
      res = session.get("/connectors/#{connector_id}")
      if res
        Connector.new(session, res["id"], res["type"])
      else
        false
      end
    end

    def create(type)
      connector = new(type)
      if connector.save
        connector
      else
        false
      end
    end
  end

end
