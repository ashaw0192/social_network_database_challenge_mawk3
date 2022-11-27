Two Tables Design Recipe Template

1. Extract nouns from the user stories or specification

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

user account, email address, username, posts, title, content, number of views

2. Infer the Table Name and Columns

Record - Properties
user accounts - email address, username
posts - title, contents, number of views

Name of the first table (always plural): accounts

Column names: email, username

Name of the second table (always plural): posts

Column names: title, content, views

3. Decide the column types.

Table: accounts
id: SERIAL
email: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int

4. Decide on The Tables Relationship

Can one [ACCOUNT] have many [POSTS]? Yes
Can one [POST] have many [ACCOUNTS]? No
You'll then be able to say that:

[ACCOUNT] has many [POSTS]
And on the other side, [POSTS] belongs to [ACCOUNTS]
In that case, the foreign key is in the table [POSTS]

4. Write the SQL.

-- file: resources/social_netword_tables.sql

-- Create the table without the foreign key first.
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  email text,
  username text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
-- The foreign key name is always {other_table_singular}_id
  account_id int,
  constraint fk_account foreign key(account_id)
    references accounts(id)
    on delete cascade
);

5. Create the tables.

psql -h 127.0.0.1 database_name < albums_table.sql
