require 'pry'

class Artist
    attr_accessor :name, :song, :musicimporter, :musiclibrarycontroller
    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def add_song(song)
        song.artist = self unless song.artist
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

    def self.create(artist)
        artist = self.new(artist)
        artist.save
        artist
    end

    def genres
        songs.collect{ |s| s.genre }.uniq
    end

    def songs 
        Song.all.select { |s| s.artist == self }
    end

end