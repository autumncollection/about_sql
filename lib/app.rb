# encoding : utf-8
require 'bundler/setup'
require 'sinatra'
require 'sinatra/namespace'
require 'slim'
require 'database'

class App < Sinatra::Application

  set :slim,   :pretty => true
  set :root,   File.dirname(__FILE__)
  set :layout, File.dirname(__FILE__) + '/../views/application'
  set :views,  File.dirname(__FILE__) + '/../views'
  set :public_folder, 'public'
  set :show_exceptions, true

  helpers do

    def s(where)
      slim :"#{where}", layout: :'application'
    end

    def get_breweries
      @breweries = DB[:Breweries].all
    end

    def get_brewery id
      @brewery = DB[:Breweries].where(id: id.to_i).first
    end

    def get_brands id
      @brands = DB[:Brands].where(brewery_id: id)
    end

    def get_brand id
      @brand = DB[:Brands].where(id: id).first
    end

  end

  post '/brewery/:brewery_id/brand' do
    DB[:Brands].insert(
      name: params['name'],
      voltage: params['voltage'],
      brewery_id: params['brewery_id']
    )
    redirect to("/brewery/#{params['brewery_id']}")
  end

  get '/' do
    get_breweries
    s :'index'
  end


  get '/brewery/:brewery_id' do
    get_brewery params['brewery_id']
    get_brands  params['brewery_id']
    s :'brewery'
  end

  put '/brewery/:brewery_id' do
    DB[:Breweries].where(id: params['brewery_id'].to_i).
      update(name: params['name'], address: params['address'])
    redirect to('/')
  end

  delete '/brewery/:brewery_id' do
    DB[:Breweries].where(id: params['brewery_id'].to_i).delete
    redirect to('/')
  end

  get '/brewery/:brewery_id/edit' do
    get_brewery params['brewery_id']
    get_breweries
    s :'index'
  end

  post '/brewery' do
    DB[:Breweries].insert(
      name: params['name'],
      address: params['address']
    )
    redirect to('/')
  end

  get '/brewery/:brewery_id/brand/:brand_id' do
    get_brewery params['brewery_id']
    get_brand   params['brand_id']
    get_brands  params['brewery_id']
    s :'brewery'
  end

  put '/brewery/:brewery_id/brand/:brand_id' do
    DB[:Brands].where(id: params['brand_id']).
      update(name: params['name'], voltage: params['voltage'])
    redirect to("/brewery/#{params['brewery_id']}")
  end

  delete '/brewery/:brewery_id/brand/:brand_id' do
    DB[:Brands].where(id: params['brand_id']).delete
    redirect to("/brewery/#{params['brewery_id']}")
  end

end
