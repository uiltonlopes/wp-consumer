class Connect
  def initialize(domain)
    @domain = domain
  end

  def mount_url(type, per_page, page)
    @url = URI("#{@domain.protocol}://#{@domain.host}/wp-json/wp/v2/media?per_page=#{per_page}&page=#{page}&media_type=#{type}")
    get_files
  end
  

  def get_files
    https = Net::HTTP.new(@url.host, @url.port);
    https.use_ssl = @domain.protocol == 'https' ? true : false

    request = Net::HTTP::Get.new(@url)

    response = https.request(request)
  end
end
