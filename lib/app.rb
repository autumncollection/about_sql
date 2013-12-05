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
      #@breweries = DB[:breweries].all
    end

    def get_brewery id
      #@brewery = DB[:breweries].where(id: id.to_i).first
    end

    def get_brands id
    end

    def get_brand id
    end

  end

  get '/' do
    get_breweries
    s :'index'
  end


end

