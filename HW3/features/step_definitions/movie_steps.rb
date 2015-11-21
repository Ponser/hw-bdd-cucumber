# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  alpha = page.body.index e1
  omega = page.body.index e2
  if !alpha || !omega || alpha >= omega
    fail "Page is out of order"
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |state, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  result = []
  rating_list.split(',').each do |r|
    #name = 'ratings[' + r + ']'
    name = 'ratings_' + r 
    (state == 'un') ? uncheck(name) : check(name)
    result << r
  end
  puts 'result = ' + result.to_s
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movie_count = Movie.all.length
  #puts '<!-- ' + page.html + ' -->'
  puts 'We have ' + movie_count.to_s + ' movies'
  puts "page.all('table#movies tr').count = " + page.all('table#movies tr').count.to_s
  fail "Incorrect movie count" if movie_count != (page.all('table#movies tr').count - 1)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

=begin
When /all ratings are checked/ do
  When I check the following ratings: G,PG,PG-13,R,NC-17
end
=end

# At this stage of development, this matcher only tells me the state
# of a ratings checkbox
When /^ratings "(.*)" are selected$/ do |choices|
  list = choices.split(/[,\s]+/)
  list.each do |choice|
    id = 'ratings_' + choice
    element = find_by_id(id)
    if element
      puts id + (element.checked? ? ' is' : " isn't") + ' checked'
    end
  end
end