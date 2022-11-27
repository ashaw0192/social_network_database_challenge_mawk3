{{TABLE NAME}} Model and Repository Classes Design Recipe

Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

see schema.md

2. Create Test SQL seeds

-- (file: spec/seeds_social_network.sql)

TRUNCATE TABLE accounts RESTART IDENTITY;
TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO accounts (email, username) VALUES ('one@one.com', 'one23');
INSERT INTO accounts (email, username) VALUES ('two@two.com', 'two34');
INSERT INTO accounts (email, username) VALUES ('three@gemail.com', 'three45');

INSERT INTO posts (title, content, views, account_id) VALUES('one1', 'one', 1, 1);
INSERT INTO posts (title, content, views, account_id) VALUES('two1', 'two', 2, 2);
INSERT INTO posts (title, content, views, account_id) VALUES('three1', 'three', 3, 3);
INSERT INTO posts (title, content, views, account_id) VALUES('one2', 'one one', 2, 1);
INSERT INTO posts (title, content, views, account_id) VALUES('two2', 'two two', 4, 2);
INSERT INTO posts (title, content, views, account_id) VALUES('three2', 'three three', 6, 3);

psql -h 127.0.0.1 your_database_name < seeds_social_network.sql

3. Define the class names

# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end

# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end

4. Implement the Model class

# Table name: accounts

# Model class
# (in lib/account.rb)

class Account
  attr_accessor :id, :email, :username
end

# Table name: posts

# Model class
# (in lib/post.rb)

class Account
  attr_accessor :id, :title, :content, :account_id
end

5. Define the Repository Class interface

# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

```ruby 

class AccountRepository

  # Selecting all accounts
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM accounts;

    # Returns an array of Account objects.
  end

  # Gets a single account by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  # Creates an account
  # One argument: Account object
  def create(account)
    # Executes the SQL query:
    # INSERT INTO accounts (email, username) VALUES ($1, $2)
    
    # Return nothing
  end

  # Deletes an account
  # One argument: the id (number)
  def delete(account)
    # Executes the SQL query:
    # DELETE FROM accounts WHERE id = $1

    #Returns nothing
  end

end

```
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

```ruby 

class PostRepositoy

  # Selecting all posts
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single post by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Creates a post
  # One argument: Post object
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4)
    
    # Return nothing
  end

  # Deletes a post
  # One argument: the id (number)
  def delete(post)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1

    #Returns nothing
  end

end

```

6. Write Test Examples

```ruby

# AccountRepository tests

# 1
# Get all accounts

repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  3

accounts[0].id # =>  '1'
accounts[0].email # =>  'one@one.com'
accounts[0].username # =>  'one23'

accounts[1].id # =>  '2'
accounts[1].email # =>  'two@two.com'
accounts[1].username # =>  'two34'

# 2
# Find a single account

repo = AccountRepository.new

account = repo.find(1)

account.id # =>  '1'
account.email # =>  'one@one.com'
account.username # =>  'one23'

# 3
# Create an account
repo = AccountRepository.new
new = Account.new
new.email = 'four@four.com'
new.username = 'four56'

repo.create(new)

accounts = repo.all

accounts.length # =>  4

accounts[-1].id # =>  '4'
accounts[-1].email # =>  'four@four.com'
accounts[-1].username # =>  'four56'

# 4
# Delete an account
repo = AccountRepository.new

repo.delete(1)

accounts = repo.all

accounts.length # =>  2

accounts[0].id # =>  '2'
accounts[0].email # =>  'two@two.com'
accounts[0].username # =>  'two34'

# 5 
# Trying to find nonexistant account
repo = AccountRepository.new

repo.find(4) # => Index 0 is not in range


# PostRepository tests

# 1
# Get all posts
repo = PostRepository.new

posts = repo.all

posts.length # =>  6

posts[0].id # =>  '1'
posts[0].title # =>  'one1'
posts[0].content # =>  'one'
posts[0].views # => '1'
posts[0].account_id # => '1'

posts[-1].id # =>  '6'
posts[-1].title # =>  'three2'
posts[-1].content # =>  'three three'
posts[-1].views # => '6'
posts[-1].account_id # => '3'

# 2
# Find a single post
repo = PostRepository.new

post = repo.find(2)

post.id # =>  '2'
post.title # =>  'two1'
post.content # =>  'two'
post.views # => '2'
post.account_id # => '2'

# 3
# Create a post
repo = PostRepository.new
new = Post.new
new.title = 'one3'
new.content = 'one one one'
new.views = 0
new.account_id = 1

repo.create(new)

posts = repo.all

posts.length # =>  7
posts[-1].id # =>  '7'
posts[-1].title # =>  'one3'
posts[-1].content # =>  'one one one'
posts[-1].views # =>  '0'
posts[-1].account_id # =>  '1'

# 4
# Delete a post
repo = PostRepository.new

repo.delete(1)

posts = repo.all

posts.length # =>  5

posts[0].id # =>  '2'
posts[0].title # =>  'two1'
posts[0].content # =>  'two'
posts[0].views # =>  '2'
posts[0].account_id # =>  '2'

# 5 
# Trying to find nonexistant post
repo = PostRepository.new

repo.find(10) # => Index 0 is not in range

```

7. Reload the SQL seeds before each test run

# file: spec/student_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'accounts' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_accounts_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

