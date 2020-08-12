class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
        VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * 
        FROM pokemon
        WHERE id = ?
        LIMIT 1
    SQL
    db.execute(sql, id).map do |row|
      id, name, type = row[0], row[1], row[2]
      Pokemon.new(id: id, name: name, type: type, db: db)
    end.first
  end
end
