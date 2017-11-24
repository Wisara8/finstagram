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
            "User #{username} saved!"
        else
            erb:signup
        end
    
end
