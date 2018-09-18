require("pg")

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :status
  attr_reader :id
  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @address = options["address"]
    @value = options["value"].to_i
    @number_of_bedrooms = options["number_of_bedrooms"].to_i
    @status = options["status"]
  end

  def save()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql ="INSERT INTO properties
    (address, value, number_of_bedrooms, status)
    VALUES
    ($1, $2, $3, $4)
    RETURNING *"

    values = [@address, @value, @number_of_bedrooms, @status]

    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i

    db.close()
  end

  def delete()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "DELETE FROM properties WHERE id = $1"

    values = [@id]

    db.prepare("delete", sql)
    properties = db.exec_prepared("delete", values)
    db.close
  end

  def update()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql ="UPDATE properties SET
    (address, value, number_of_bedrooms, status)
    =
    ($1, $2, $3, $4)
    WHERE id = $5"

    values = [@address, @vaue, @number_of_bedrooms, @status, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)

    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties"

    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    # return properties
    return properties.map{|property_hash| Property.new(property_hash)}
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "DELETE FROM properties"

    db.prepare("delete_all", sql)
    properties = db.exec_prepared("delete_all")
    db.close()
  end

  def Property.find_by_id(id)
    # binding.pry
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE id = $1"

    values = [id]

    db.prepare("find_by_id", sql)
    properties = db.exec_prepared("find_by_id", values)
    db.close()
    # binding.pry
    return properties.map{|property_hash| Property.new(property_hash)}
  end

  def Property.find_by_address(addr)
    # binding.pry
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE address = $1"

    values = [addr]

    db.prepare("find_by_addr", sql)
    properties = db.exec_prepared("find_by_addr", values)
    db.close()
    # binding.pry
    return properties.map{|property_hash| Property.new(property_hash)}
  end

end
