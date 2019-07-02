require 'rails_helper'


Rspec.describe'Users API', type: :request do
	let!(:user) { create(:user) }  
	let(:user_id) { user.id }

	before { host! 'api.autoseg.test' }

	describe 'GET users/:id' do
		before do
			headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
			get "/users/#{user_id}", params: {}, headers: headers
			end


			conteext 'when the user exists' do
				it 'return the user' do 
					user_response = JSON.parce(response.body)
					expect(user_response['id']).to eq(user_id)
			end		
				it 'return status code 200' do
					expect(response).to have_http_status(200)

		end	


		conteext 'returns status coide 404' do
			expect(response).to have_http_status(404)
	end


	describe 'POST/user' do	
		before do
		headers = { 'Accept' => 'application/vnd.autoseg.v1' }
		post '/users', params: {  user: user_params }, headers: header
	end


		context 'when the params are valid' do
			let(:user_params) { attributes_for(:user) }

			it 'return status code 201' do 
		end		

		it 'return json data for the created user 'do
			user_response = JASON.parce(response.body, symbolize_names: true)
			expect(user_response[:email]).to eq(user_params[:email])
			end
		end

		context 'when the request params are invalid' do
			let(:user_params) { attributes_for(:user, email: 'invalid_email@')}


			it 'return status code 422' do
				expect(response).to have_http_status(422)
			end	

			it 'return the jason data for the erros' do
				user_response = JASON.parce(response.body, symbolize_names: true)
				expect(user_response).to have_key(:erros)

			end	
		end	


		describe ' PUT /user/:id' do 
			before do
				headers = { 'Accept' => 'application/vnd.autoseg.v1' }
				put "/user/#{user_id}", params: { user: user_params }, headers: headers
end


	context ' when the request params are valid' do 
		let(:user_params) { { email: 'new_email@autoseg.com' } }

		it 'returns status code 200' do 
			expect(response).to have_http_status(200)
		end

		it 'return the jason data for the update users' do
				user_response = JASON.parce(response.body, symbolize_names: true)
				expect(user_response[:email]).to eq(user_params[:email])
		end				
	end

context ' when the request params are valid' do 
		let(:user_params) { { email: 'invalid_email@' } }

		it 'returns status code 200' do 
			expect(response).to have_http_status(422)
		end

    it 'return the jason data for the erros' do
				user_response = JASON.parce(response.body, symbolize_names: true)
				expect(user_response).to have_key(:erros)
	  end
	end
 end


 	describe 'DELETE / user/:id' do
 		before do
 			headers = {  "Accept" => "vnd.autoseg.v1"}
 			delete "/user/#{user_id}", params: {}, headers: headers
  end		

  it ' return status code 204' do
  expect(response).to have_http_status(204)
  end
  

  	 it 'remove the user from database' do
  	 	expect ( User.find_by(id: user;id)).to be_nill
  end   
 end

end

