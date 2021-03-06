require 'rails_helper'


Rspec.describe'Users API', type: :request do
	let!(:user) { create(:user) }  
	let!(:auth_data) { user.create_new_auth_token }
	let(:headers) do
		{

		'Accept' => 'application/vnd.autoseg.v1',
		'content-type' => Mime[:json].to_s, 
		'access-token' => auth_data['access-token'],
		'uid' => auth_data['uid'],
		'client' => auth_data['client']
		}
	end

	before { host! 'api.autoseg.test' }

	describe 'GET /auth/validate_token' do
	  before do
			get '/auth/validate_token', params: {}, headers: headers
			end


			context 'when the reques headers are valid' do
				it 'return the user id' do 
					expect(json_body[:data][:id].to_i).to eq(user.id)
			end		



				it 'return status code 200' do
					expect(response).to have_http_status(200)

		end	
   end

   	context 'when the reques not headers are valid' do
		 before do
		 	  #headers['access-token'] = "invalid_token"
		  	get '/auth/validate_token', params: {}, headers: headers
			end

		context 'returns status code 401' do
			expect(response).to have_http_status(401)
	end
 end	
end

	describe 'POST/auth' do	
		before do
		post '/auth', user_params: user_params.to_json, headers: header
	end


		context 'when the params are valid' do
			let(:user_params) { attributes_for(:user) }

			it 'return status code 200' do
			  expect(response).to have_http_status(200) 
		end		

		it 'return json data for the created user 'do
			expect(json_body[:data][:email]).to eq(user_params[:email])
			end
		end

		context 'when the request params are invalid' do
			let(:user_params) { attributes_for(:user, email: 'invalid_email@')}


			it 'return status code 422' do
				expect(response).to have_http_status(422)
			end	

			it 'return the jason data for the erros' do
				expect(json_body).to have_key(:errors)

			end	
		end	


		describe ' PUT /auth/:id' do 
			before do
				put '/auth', params: user_params.to_json, headers: headers
end


	context ' when the request params are valid' do 
		let(:user_params) { { email: 'new_email@autoseg.com' } }

		it 'returns status code 200' do 
			expect(response).to have_http_status(200)
		end

		it 'return the jason data for the update users' do
				expect(json_body[:data][:email]).to eq(user_params[:email])
		end				
	end

context ' when the request params are valid' do 
		let(:user_params) { { email: 'invalid_email@' } }

		it 'returns status code 422' do 
			expect(response).to have_http_status(422)
		end

    it 'return the jason data for the erros' do
				expect(json_body).to have_key(:erros)
	  end
	end
 end


 	describe 'DELETE /auth' do
 		before do
 			delete '/auth', params: {}, headers: headers
  end		

  it ' return status code 200' do
  expect(response).to have_http_status(200)
  end
  

  	 it 'remove the user from database' do
  	 	expect ( User.find_by(id: user;id)).to be_nill
  end   
 end

end


