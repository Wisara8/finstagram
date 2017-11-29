helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end


get '/' do
    @posts = Post.order(created_at: :desc)
    erb:index
end

get '/signup' do        #If a user navigates to path "/signup",
    @user = User.new    #Setup empty user object
    erb:signup          #render actions/user/signup.erb
end

post '/signup' do
    #grab user params from params
    email=params[:email]
    avatar_url=params[:avatar_url]
    username=params[:username]
    password=params[:password]
    
        #instantiate and save user
        @user=User.new({email: email, avatar_url: avatar_url, username: username, password: password})
        
        #if validations pass and user is saved
        if @user.save
            redirect to('/login')
        else
            erb:signup
        end
    
end

get '/login' do
    erb:login
end

post '/login' do
    username = params[:username]
    password = params[:password]
    
    user = User.find_by(username: username)
    
    if user && user.password == password
        session[:user_id] = user.id
        redirect to('/')
    else
        @error_message = "Invalid!"
        erb:login
    end
end
    
get '/logout' do
    session[:user_id] = nil
    redirect to('/')
end






