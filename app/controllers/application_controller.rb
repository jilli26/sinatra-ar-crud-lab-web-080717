require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #create
  get '/posts/new' do
    erb :new
  end

  #create
  post '/posts' do
    @post = Post.create(params)
    erb :posts
  end

  #read - index
  get '/posts' do
    @posts = Post.all
    erb :index
  end

  #read - show (find by id)
  get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    erb :show
  end

  #update - render update form
  get '/posts/:id/edit' do
    @post = Post.find_by(id: params[:id])
    erb :edit
  end

  #update - patch/catch post request
  patch '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save

    redirect to "/posts/#{@post.id}"

    erb :show
  end

  #delete - delete button is a form
  delete '/posts/:id/delete' do
    @post = Post.find_by(id: params[:id])
    @post.destroy

    erb :deleted
  end

end
