require "open-uri"
require "net/http"

class MyHttp

  def getBody(uri)
    return nil if uri=='' || uri == nil
    html_response = nil
    open(uri) do |http|   
      html_response = http.read   
    end  
	
#	uri = URI(uri)
#    res = Net::HTTP.get(uri)
#	res.body
  end
  
  def download(url,filename)
    content = getBody(url)
	File.open(filename,'w') do |file|
	  file.puts content
	end
  end

end

