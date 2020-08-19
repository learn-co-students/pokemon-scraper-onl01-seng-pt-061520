class Pokemon
    attr_accessor :id, :name, :type, :db
    def initialize(traits)
      @id, @name, @type, @db = id, name, type, db
    end

    def self.save(name,type,db)
      db.execute("INSERT INTO pokemon(name, type) VALUES (?, ?)",name,type)
    end

    def self.find(num,db)
     find_pokemon = db.execute("SELECT * FROM pokemon WHERE id=?",[num])
     pokemon=self.new(find_pokemon)
     pokemon.id = find_pokemon[0][0]
     pokemon.name = find_pokemon[0][1]
     pokemon.type = find_pokemon[0][2]
     pokemon
    end
end
