require 'backports'
require 'rest-client'
require 'json'

module Cloudq
  class Publish < Base
    def job(klass, *args)
      jsonized_job = jsonize(:job => { :klass => klass, :args => args})
      post(jsonized_job)
    end

  private
    def post(data)
      headers = {:content_type => :json, :accept => :json}
      # RestClient.post [Cloudq::Connection.url, @queue].join('/'), data, headers do |response|
      #   JSON.parse(response)['status'] == 'success'
      # end
      resp = RestClient.post [Cloudq::Connection.url, @queue].join('/'), data, headers
      JSON.parse(resp)['status'] == 'success'

    end

    def jsonize(data)
      data.to_json
    end

  end
end
