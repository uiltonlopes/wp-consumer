class Connect
  def initialize(domain)
    @domain = domain
  end

  def mount_url(type, per_page, page)
    @url = URI("#{@domain.protocol}://#{@domain.host}/wp-json/wp/v2/media?per_page=#{per_page}&page=#{page}&orderby=id&order=desc&media_type=#{type}")
    get_files
  end

  def users(per_page, page)
    @url = URI("#{@domain.protocol}://#{@domain.host}/wp-json/wp/v2/users?per_page=#{per_page}&page=#{page}&orderby=id&order=desc")
    get_files
  end

  def search(q, per_page, page)
    @url = URI("#{@domain.protocol}://#{@domain.host}/wp-json/wp/v2/media?per_page=#{per_page}&page=#{page}&orderby=id&order=desc&search=#{q}")
    get_files
  end

  def download
    @url = URI("#{@domain.protocol}://#{@domain.host}/wp-json/wp/v2/envira-gallery/10265")
    result = get_files
    gallery = JSON.parse(result.read_body, symbolize_names: true)
    gallery[:gallery_data][:gallery].each do |image|
      puts `curl -O #{image[:link]}`
    end
  end

  def get_files
    https = Net::HTTP.new(@url.host, @url.port);
    https.use_ssl = @domain.protocol == 'https' ? true : false

    request = Net::HTTP::Get.new(@url)

    response = https.request(request)
  end
end
