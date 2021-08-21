require 'pry'

class MusicImporter
    attr_accessor :path, :song, :artist, :genre, :musiclibrarycontroller

    def initialize(path)
        @path = path

    end

    def files
        @files = Dir.entries(@path)
        @files.delete_if {|k| k == "." || k == ".."}
    end

    def import 
        files.each{|l| Song.create_from_filename(l)}
    end




end