class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize (attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL

        # 
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL

        result = db.execute(sql, id)[0]
        pokemon = Pokemon.new(db: db)
        pokemon.id = result[0]
        pokemon.name = result[1]
        pokemon.type = result[2]
        pokemon
    end


end
