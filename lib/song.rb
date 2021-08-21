require 'pry'

class Song
    attr_accessor :name, :artist, :genre, :musicimporter

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        self.class.all << self
        self
    end

    def songs
        @songs
    end

    def self.create(name)
        new(name).save
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self #unless genre.songs.include?(self)
    end

    def genre
        @genre
    end

    def self.find_by_name(name)
        @@all.detect do |song|
          song.name == name
        end
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(file)
        artist, song, genre = file.split(" - ")
        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(genre.split(".mp3").join)
        self.new(song, artist, genre)
    end

    def self.create_from_filename(file)
        self.new_from_filename(file).save
    end

   


end