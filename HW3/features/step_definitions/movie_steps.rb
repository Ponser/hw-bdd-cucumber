# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  list = Movie.all
  puts 'The database has ' + list.length.to_s + ' movies'
  titles = Array.new
  list.each {|x| puts x.to_s}
  puts "I have these titles:"
  list.each {|x| puts x}
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    puts 'I have this: ' + movie[:title]
    #found = true
    #Movies.all.each{|x| puts x.title}
    #Movies.all.each{|x| found = true if x.title == movie.title}
    #puts 'I ' + (found ? ' ' : "don't ") + 'have "' + movie.title + '"'
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  puts e1.to_s + ' .AND. ' + e2.to_s
  fail "Ain't right"
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |state, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |r|
    name = 'ratings[' + r + ']'
    puts 'Looking at check box ' + name
    (state == 'un') ? uncheck(name) : check(name)
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  fail "Unimplemented"
end

=begin
When /I am on the RottenPotatoes home page/ do
  #visit path_to(page_name)
  visit path_to('/movies')
  puts 'What the actual ****?'
  fail "Misunderstood"
end
=end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end
