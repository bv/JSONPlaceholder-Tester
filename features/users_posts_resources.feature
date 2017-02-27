Feature: Fake Online REST API for Testing and Prototyping
  Let's check the 'users' and 'posts' resources
  as well as post a fake post

  Scenario: Get a random user (userID),
    print its address to output,
    and verify email format is correct
    deal with users posts and post a new one

# a)
    Given There are users available
    When I get a random user
    Then I can print its address to output
     And The user's email format is correct

# b)      
    When I get user's posts
    Then the posts have proper ids
     And the posts have proper title
     And the posts have proper body

# c)
    When I post as the user
    Then The response is a valid post
