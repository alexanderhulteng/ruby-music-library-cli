require 'pry'


class Genre
    attr_accessor :name, :musicimporter, :musiclibrarycontroller
    extend Concerns::Findable
    
    


    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        @@all << self
    end

    def self.create(genre)
        genre = self.new(genre)
        genre.save
        genre
    end

    def songs 
        Song.all.select { |s| s.genre == self }
    end
    
    def artists
        songs.collect{ |s| s.artist }.uniq
    end



end