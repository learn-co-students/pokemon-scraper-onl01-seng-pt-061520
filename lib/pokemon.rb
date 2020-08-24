class Pokemon
    attr_accessor :name, :type, :db, :id

    def initialize (id:, name:, type:, db:)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid()")[0][0]
    end

    def self.find(id, base)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = base.execute(sql, id)[0]
        pk = Pokemon.new(id: result[0], name: result[1], type: result[2], db: base)
        pk
    end
end
