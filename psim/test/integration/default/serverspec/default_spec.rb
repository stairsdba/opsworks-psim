require 'spec_helper'

require 'json'
require 'net/http'

set :backend, :cmd
set :os, :family => 'windows'

describe 'cps_listen' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'responds on port 80' do
    expect(port 80).to be_listening 'tcp'
  end
  
end

# Validate that cps started with https
describe port(443) do
   it { should be_listening }
end

# validate that ponconf has started
describe port(8057) do
  it { should be_listening }
end

# validate that pas is listening on the proper ports
describe 'pas_listen' do
  it 'responds on port 5200' do
    expect(port 5200).to be_listening 'tcp'
  end
  
  it 'responds on port 5400' do
    expect(port 5400).to be_listening 'tcp'
  end
end

# validate the cps main page, shows cps starts
describe 'cps submission page' do
   it 'localhost/cps responds' do
     url = URI('http://127.0.0.1/cps/')
	 
	 response = Net::HTTP.get_response(url)
	 
	 expect(response.code).to eq 200
   end
   
   
end

