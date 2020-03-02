class Connect
  def initialize(domain)
    @domain = domain
  end

  def list_images(per_page,page)
    url = URI("#{@domain.protocol}://#{@domain.host}/wp-json/wp/v2/media?per_page=#{per_page}&page=#{page}&media_type=image")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = @domain.protocol == 'https' ? true : false

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
  end
end
