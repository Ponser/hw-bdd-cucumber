# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  @movie_count = movies_table.hashes.length
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
  rating_list.split(',').each do |r|
    #name = 'ratings[' + r + ']'
    name = 'ratings_' + r 
    (state == 'un') ? uncheck(name) : check(name)
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  n = 0
  @movie_count.times do 
    n = page.body.index('More about', n + 1)
    fail "Not enough movies" if !n
  end
  fail "Too many movies" if page.body.index('More about', n + 1)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end
