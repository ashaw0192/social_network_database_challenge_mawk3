TRUNCATE TABLE accounts, posts RESTART IDENTITY;

INSERT INTO accounts (email, username) VALUES ('one@one.com', 'one23');
INSERT INTO accounts (email, username) VALUES ('two@two.com', 'two34');
INSERT INTO accounts (email, username) VALUES ('three@gemail.com', 'three45');

INSERT INTO posts (title, content, views, account_id) VALUES('one1', 'one', 1, 1);
INSERT INTO posts (title, content, views, account_id) VALUES('two1', 'two', 2, 2);
INSERT INTO posts (title, content, views, account_id) VALUES('three1', 'three', 3, 3);
INSERT INTO posts (title, content, views, account_id) VALUES('one2', 'one one', 2, 1);
INSERT INTO posts (title, content, views, account_id) VALUES('two2', 'two two', 4, 2);
INSERT INTO posts (title, content, views, account_id) VALUES('three2', 'three three', 6, 3);