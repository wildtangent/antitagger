#!/usr/bin/ruby
require './lib/antitagger.rb'

antitagger = Antitagger.new("./content/article.html", "postland-theory", "periscoping", "foobar")
puts antitagger.untag!