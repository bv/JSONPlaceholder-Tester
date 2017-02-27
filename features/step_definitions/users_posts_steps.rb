Given(/^There are users available$/) do
  get_all_users_url = users_url()
  all_users = JSON.parse RestClient.get(get_all_users_url, headers={})
  assert_equal(
    Array,
    all_users.class,
    "The '#{get_all_users_url}' request should return collection of users (Array)")
  
  @user_ids ||= all_users.map { |user| user['id']}
  puts "There are users available with ids: #{@user_ids}" 
end

When(/^I get a random user$/) do
  last_id_index = @user_ids.count - 1
  an_id = @user_ids[Random.rand 0..last_id_index]
  get_user_url = "#{users_url()}/#{an_id}"
  @random_user ||= JSON.parse RestClient.get(get_user_url, headers={})
  @the_user = @random_user # the user under test
  puts " - randomly selected user with id: #{an_id}"
end

Then(/^I can print its address to output$/) do
  # assuming 'I can print' means that the 'address' portion
  # should exist in the user structure received at this point 
  #expect(@the_user).to have_key('address')
  refute_nil(
    @the_user['address'],
    "The structure representing the user has no 'address' field available")
  
  puts " - the user's address is: #{JSON.pretty_generate(@the_user['address'])}"
end

Then(/^The user's email format is correct$/) do
  the_email = @the_user['email']
  assert(
    valid_emil?(the_email),
    "The email retrieved is not valid, as per the pattern")
  
  puts " - the user's email is: #{the_email}"
end

#============
When(/^I get user's posts$/) do
  @the_user_id = @the_user['id']
  get_posts_for_user_url = "#{posts_for_user_url()}#{@the_user_id}"
  @all_posts_of_user = JSON.parse RestClient.get(get_posts_for_user_url, headers={})
  assert_equal(
    Array,
    @all_posts_of_user.class,
    "The '#{get_posts_for_user_url}' request should return collection of posts (Array)")

  puts " - the user has this many posts: #{@all_posts_of_user.count}"
end

Then(/^the posts have proper ids$/) do
  improper_ids = @all_posts_of_user.map{ |post| 
    {post['id'] => valid_id?(post['id']), :post => post}
  }.delete_if{ |pair|
    pair.has_value?(true)}

  assert_empty(improper_ids, "There are improper ids")
end

Then(/^the posts have proper title$/) do
  improper_titles = @all_posts_of_user.map{ |post| 
    {post['title'] => valid_post_title?(post['title']), :post => post}
  }.delete_if{ |pair|
    pair.has_value?(true)}

  assert_empty(improper_titles, "There are improper titles")
end

Then(/^the posts have proper body$/) do
  improper_bodies = @all_posts_of_user.map{ |post| 
    {post['body'] => valid_post_body?(post['body']), :post => post}
  }.delete_if{ |pair|
    pair.has_value?(true)}

  assert_empty(improper_bodies, "There are improper bodies")
end

When(/^I post as the user$/) do
  a_proper_post = {
    title: 'Proper title goes here',
    body: "The Washington Post Communications department is made up of two teams.",
    userId: @the_user_id
  }
  @post_result = JSON.parse RestClient.post(posts_url(), a_proper_post.to_json, {content_type: :json, accept: :json})
#   puts @post_result
end

Then(/^The response is a valid post$/) do
  actual_response = @post_result
  expected_response = {
    'title' => 'Proper title goes here',
    'body' => 'The Washington Post Communications department is made up of two teams.',
    'userId' => @the_user_id,
    'id' => 101}
  assert_equal(expected_response, actual_response)
  puts " - the post result is: #{JSON.pretty_generate(@post_result)}"
end