#!/usr/bin/env ruby

require 'yaml'
require 'namey'
require 'httparty'

require './actor'
require './place'

require './init'
require './travel'
require './events'


@actors = []
@places = []

def narrator_intro
end

def status
  @actors.each { |a|
    puts "#{a} is in #{a.location}"
  }
end

def random_actor(except:nil)
  @actors.reject { |a| except && except.include?(a) }.sample
end

load_data

@narrator = @actors.first
@best_friend = @narrator

@best_friend = random_actor(except:[@narrator])

status

narrator_intro

#
# Chapter One: Narrator and Friend have fun in current location, with
# another person or two
#
puts fun_event(@best_friend, @narrator, @new_person)
puts big_conversation(@best_friend, @narrator, @new_person)

#
# Chapter Two: Narrator and Pal go on a trip somewhere
#
trip(who:[@best_friend], visiting:@narrator)
@new_person = random_actor(except:[@narrator, @best_friend])
fun_event(@best_friend, @narrator, @new_person)

@new_person = random_actor(except:[@narrator, @best_friend, @new_person])

#
# Chapter Three: Narrator and Pal visit new person
#
puts "lets visit #{@new_person}"
trip(who:[@best_friend, @narrator], visiting:@new_person)
status

puts fun_event(@best_friend, @narrator, @new_person)
puts big_conversation(@best_friend, @narrator, @new_person)

#
# Chapter Four: Narrator travels and gets a job
#
trip(who:[@narrator], dest:@places.sample)
puts random_job(@narrator)

#
# Chapter Five: best friend shows up again, wants to look for lost
# relative
#

#
# Closing: dumped on the road
#

def search_for_family
  puts "#{@best_friend} wants to search for long-lost father/mother/etc"
end

search_for_family


