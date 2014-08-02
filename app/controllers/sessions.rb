get '/sessions/new' do 
	erb :"sessions/new"
end

post '/sessions' do 
	handle, password = params[:handle], params[:password]
	user = User.authenticate(handle, password)
	if user 
		session[:user_id] = user.id 
		redirect to('/')
	else
		flash[:errors] = ["That handle or password is incorrect"]
		erb :"sessions/new"
	end
end

delete '/sessions/sign_out' do 
	session[:user_id] = nil
	flash[:notice] = "Goodbye!"
	redirect to('/')
end