require_relative '../lib/account_repository'

def reset_social_network
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe AccountRepository do
  
  before(:each) do 
    reset_social_network
  end

  it "retrieves all accounts" do
    repo = AccountRepository.new

    accounts = repo.all

    expect(accounts.length).to eq 3
    expect(accounts[0].id).to eq '1'
    expect(accounts[0].email).to eq 'one@one.com'
    expect(accounts[0].username).to eq 'one23'
    expect(accounts[1].id).to eq '2'
    expect(accounts[1].email).to eq 'two@two.com'
    expect(accounts[1].username).to eq 'two34'

  end

  it "find one account" do
    repo = AccountRepository.new

    account = repo.find(1)

    expect(account.id).to eq '1'
    expect(account.email).to eq 'one@one.com'
    expect(account.username).to eq 'one23'
  end

  it "creates an account" do
    repo = AccountRepository.new
    new = Account.new
    new.email = 'four@four.com'
    new.username = 'four56'

    repo.create(new)

    accounts = repo.all

    expect(accounts.length).to eq 4
    expect(accounts[-1].id).to eq '4'
    expect(accounts[-1].email).to eq 'four@four.com'
    expect(accounts[-1].username).to eq 'four56'
  end

  it "deletes an account" do
    repo = AccountRepository.new

    repo.delete(1)
    
    accounts = repo.all
    
    expect(accounts.length).to eq 2
    expect(accounts[0].id).to eq '2'
    expect(accounts[0].email).to eq 'two@two.com'
    expect(accounts[0].username).to eq 'two34'
  end

  it "fails when looking for nonexistant id" do
    repo = AccountRepository.new

    expect{ repo.find(4) }.to raise_error 'Index 0 is out of range'
  end

end