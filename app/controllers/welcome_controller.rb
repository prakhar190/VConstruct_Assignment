class WelcomeController < ApplicationController
    def index 
    end

    def fetch_data
        
        
        fetch_apis_asynchronously

        # merge the responses from
        @merged_response = [@resp1, @resp2].as_json

        puts "Response 1 >>>>>>>>>>>>>>>>>>"
        puts @resp1
        puts "Response 1 end >>>>>>>>>>>>>>"

        puts "Response 2 >>>>>>>>>>>>>>>>>>"
        puts @resp2
        puts "Response 2 end >>>>>>>>>>>>>>"

        puts "Merged Response >>>>>>>>>>>>>>>>>>>>"
        puts @merged_response
        puts "Response Response end >>>>>>>>>>>>>>"

        # set the merged response in cookies for 1 hour
        set_data_in_cookie(@merged_response)
        # threads = []
        # threads << Thread.new { 3.times { puts "Fuck you" } }
        # threads << Thread.new { 3.times { puts "Threads are fun!" } }
        # threads.each { |thr| thr.join }
    end

    private 
        # Fetches the api responses asynchronously
        def fetch_apis_asynchronously 
            threads = []
            threads << Thread.new { @resp1 = RestClient.get 'https://reqres.in/api/unknown' }
            threads << Thread.new { @resp2 = RestClient.get 'https://reqres.in/api/products' }
            threads.each { |thr| thr.join }  
        end

        # sets the data in cookies for 1 hour
        def set_data_in_cookie(data)
            cookies[:merged_response] = {
                :value => data,
                :expires => 1.hour.from_now,
            
            }
        end


end
