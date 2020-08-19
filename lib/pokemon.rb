class Pokemon
  # use keyword for initialize "keyword:"

  attr_accessor :name, :type, :db, :id

  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(pk_name, pk_type, db)
    pokemon = Pokemon.new(name: pk_name, type: pk_type, db: db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, pokemon.name, pokemon.type)
    pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    result = db.execute(sql, id)[0]
    Pokemon.new(id: result[0], name: result[1], type: result[2], db: db)
  end

  def self.new_from_db(name)
    sql = "SELECT * FROM pokemon WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    Pokemon.new(result[0], result[1], result[2], result[3])
  end

  def update
    sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.type, self.id)
  end

  def remove
    sql = "DELETE FROM pokemon WHERE id = ?"
    DB[:conn].execute(sql, self.id)
  end

end
