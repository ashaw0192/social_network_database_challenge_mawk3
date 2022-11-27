require_relative '../lib/post_repository'

def reset_social_network
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do

  before(:each) do 
    reset_social_network
  end

  it "shows all posts" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq  6
    expect(posts[0].id).to eq '1'
    expect(posts[0].title).to eq 'one1'
    expect(posts[0].content).to eq 'one'
    expect(posts[0].views).to eq '1'
    expect(posts[0].account_id).to eq '1'
    expect(posts[-1].id).to eq '6'
    expect(posts[-1].title).to eq 'three2'
    expect(posts[-1].content).to eq 'three three'
    expect(posts[-1].views).to eq '6'
    expect(posts[-1].account_id).to eq '3'
  end

  it "finds a post" do
    repo = PostRepository.new

    post = repo.find(2)

    expect(post.id).to eq '2'
    expect(post.title).to eq 'two1'
    expect(post.content).to eq 'two'
    expect(post.views).to eq '2'
    expect(post.account_id).to eq '2'
  end

  it "creates a post" do
    repo = PostRepository.new
    new = Post.new
    new.title = 'one3'
    new.content = 'one one one'
    new.views = 0
    new.account_id = 1
    
    repo.create(new)
    
    posts = repo.all
    
    expect(posts.length).to eq 7
    expect(posts[-1].id).to eq '7'
    expect(posts[-1].title).to eq 'one3'
    expect(posts[-1].content).to eq 'one one one'
    expect(posts[-1].views).to eq '0'
    expect(posts[-1].account_id).to eq '1'
  end

  it "deletes a post" do
    repo = PostRepository.new

    repo.delete(1)
    
    posts = repo.all
    
    expect(posts.length).to eq 5
    expect(posts[0].id).to eq '2'
    expect(posts[0].title).to eq 'two1'
    expect(posts[0].content).to eq 'two'
    expect(posts[0].views).to eq '2'
    expect(posts[0].account_id).to eq '2'
  end

  it "fails if trying to find a post that doesnt exist" do
    repo = PostRepository.new

    expect{ repo.find(10) }.to raise_error 'Index 0 is out of range'
  end

end