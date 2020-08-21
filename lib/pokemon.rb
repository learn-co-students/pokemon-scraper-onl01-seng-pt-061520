class Pokemon
    attr_accessor :name, :type, :db,:id 
    def initialize(id:, name:, type:, db:)
        @id = id 
        @name = name 
        @type = type 
        @db = db 
    end 

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES(?,?)", [name, type])
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end 

    def self.find(i, d)
        a = d.execute("SELECT * FROM pokemon WHERE id = ?", [i])
        puts a[0][1]
        b = Pokemon.new(id: i, name: a[0][1], type: a[0][2], db: d) 
        b 
    end 
end
