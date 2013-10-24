require 'bundler'
require './lib/idea_box'

Bundler.require

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  helpers do

    def idea_path(idea=nil)
      if idea
        "ideas/#{idea.id}"
      else
        "ideas"
      end
    end
  end

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort,
                         idea: Idea.new}
  end

  post '/ideas/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  delete '/ideas/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/ideas/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/ideas/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  get '/ideas/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :idea, locals: {idea: idea, ideas: IdeaStore.all.sort}
  end

  post '/ideas' do
    IdeaStore.create(params[:idea]) if params[:idea]
    redirect '/'
  end

  get '/sms' do
    title, description = params[:Body].split(", ")
    attributes = {"title" => title, "description" => description}
    idea = Idea.new(attributes)
    idea.save
    redirect '/'
  end

  configure :development do
    register Sinatra::Reloader
  end

end
