#!/usr/bin/env ruby

require 'yaml'
require 'namey'
require 'httparty'

require './actor'
require './place'

require './init'
require './travel'



@actors = []
@places = []


load_data

@narrator = @actors.first
@best_friend = @narrator

@best_friend = @actors.sample while @best_friend == @narrator


def narrator_intro
end

narrator_intro
trip(who:[@best_friend], visiting:@narrator)

@new_person = @narrator
@new_person = @actors.sample while (@best_friend == @new_person || @new_person == @narrator)
puts "lets visit #{@new_person}"
trip(who:[@best_friend, @narrator], visiting:@new_person)

