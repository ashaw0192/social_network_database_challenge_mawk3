require_relative './post'

class PostRepository

  def fill(unfilled)
    filled = Post.new
    filled.id = unfilled['id']
    filled.title = unfilled['title']
    filled.content = unfilled['content']
    filled.views = unfilled['views']
    filled.account_id = unfilled['account_id']
    filled
  end

  def all
    sql = 'SELECT id, title, content, views, account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    posts_array = []
    result_set.each do |post|
      posts_array << fill(post)
    end
    posts_array
  end

  def find(id)
    sql = 'SELECT * FROM posts WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    fill(result[0])
  end

  def create(new)
    sql = 'INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4);'
    params = [new.title, new.content, new.views, new.account_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end
end