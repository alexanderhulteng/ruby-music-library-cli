require 'pry'

class MusicLibraryController
    attr_accessor :path
    def initialize(path = './db/mp3s')
        @path = path
        MusicImporter.new(path).import
        
    end

    def call
        input = ""
        while input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets.strip
            
            case input
            when "list songs"
              list_songs
            when "list artists"
              list_artists
            when "list genres"
              list_genres
            when "list artist"
              list_songs_by_artist
            when "list genre"
              list_songs_by_genre
            when "play song"
              play_song
            end
        end
        
    end

    def list_songs 
        k = Song.all.sort { |a,b| a.name <=> b.name }
        k.each_with_index do |file, order|
            puts "#{order+1}. #{file.artist.name} - #{file.name} - #{file.genre.name}"
        end
    end

    def list_artists
        k = Artist.all.sort { |a,b| a.name <=> b.name }
        k.each_with_index do |file, order|
            puts "#{order+1}. #{file.name}"
        end
    end

    def list_genres
        k = Genre.all.sort { |a,b| a.name <=> b.name }
        k.each_with_index do |file, order|
            puts "#{order+1}. #{file.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        if artist = Artist.find_by_name(input)
           k = artist.songs.sort { |a,b| a.name <=> b.name }
            k.each_with_index do |file, order|
                puts "#{order+1}. #{file.name} - #{file.genre.name}"
            end
        end


    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            k = genre.songs.sort { |a,b| a.name <=> b.name }
            k.each_with_index do |file, order|
                puts "#{order+1}. #{file.artist.name} - #{file.name}"
            end
        end





    end


    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        if input > 0 && input <= Song.all.size
            k = Song.all.sort { |a,b| a.name <=> b.name }
            song = k[input-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end






    end


        
    
    




end
