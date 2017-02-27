# Validates the email address passed. The validation rules are taken from
# http://stackoverflow.com/a/22994329/215846 (as a balance between simple / strict)
#
# * *Args*    :
#   - +email+ -> the email address to be validated
# * *Returns* :
#   - true meaning the email address is valid or
#   - false meaning the email is not valid
#
def valid_emil?(email)
  # the required validation strictness can be argued and discussed
  pattern = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  return (pattern.match email).nil? ? false : true 
end

def valid_id?(id)
  invalid = (id.nil? || id.eql?(''))
  return !invalid
end

def valid_post_title?(title)
  invalid = (title.nil? || title.eql?(''))
  return !invalid
end

def valid_post_body?(body)
  invalid = (body.nil? || body.eql?(''))
  return !invalid
end

def base_url
  'https://jsonplaceholder.typicode.com'
end

def users_url
  "#{base_url}/users"
end

def posts_url
  'https://jsonplaceholder.typicode.com/posts'
end
  
def posts_for_user_url
  "#{posts_url}?userId="
end