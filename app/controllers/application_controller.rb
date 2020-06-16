class ApplicationController < Sinatra::Base

    set :views, 'app/views'
    set :method_override, true
    set :public_folder, 'stuff'

    get '/' do
      erb :home
    end
  
    get '/home' do
      erb :home
    end

   # display list of all the puppies
     get '/puppies' do
        @puppies = Puppy.all
        erb :index
    end

    # Form for creating a puppy
    get '/puppies/new' do 
        erb :new
    end

    # display single puppy info
    get '/puppies/:id' do 
        @puppy = find_puppy(params)
        erb :show
    end

    # create a puppy
    post '/puppies' do
        puppy = Puppy.create(params)
        redirect "/puppies"
    end

    # form for updating a puppy
    get '/puppies/:id/edit' do
        @puppy = find_puppy(params)
        erb :edit
    end

    # update a puppy
    patch '/puppies/:id' do
        puppy = find_puppy(params)
        puppy.update(name: params[:name], breed:params[:breed])

        redirect "/puppies/#{puppy.id}"
    end

    delete '/puppies/:id' do 
        puppy = find_puppy(params)
        puppy.destroy
        redirect "/puppies"
    end

    def find_puppy(params)
        Puppy.find(params[:id])
    end
   
end
