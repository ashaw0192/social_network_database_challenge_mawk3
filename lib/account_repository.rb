require_relative './account.rb'

class AccountRepository
  def fill(unfilled)
    filled = Account.new
    filled.id = unfilled['id']
    filled.email = unfilled['email']
    filled.username = unfilled['username']
    return filled
  end

  def all
    sql = 'SELECT * FROM accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    account_array = []
    result_set.each do |account|
      account_array << fill(account)
    end
    return account_array
  end

  def find(id)
    sql = 'SELECT * FROM accounts WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    return fill(result_set[0])
  end

  def create(account)
    sql = 'INSERT INTO accounts (email, username) VALUES ($1, $2)'
    params = [account.email, account.username]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM accounts WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

  
end