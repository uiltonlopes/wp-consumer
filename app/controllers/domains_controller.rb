class DomainsController < ApplicationController
  add_breadcrumb "<a class='breadcrumb' href='/domains'>Domain</a>".html_safe
  before_action :set_domain, only: [:show, :edit, :update, :destroy, :image, :video, :audio, :search]
  before_action :set_breadcrumb, only: [:edit, :image, :video, :audio, :search]

  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.all
    @pagy, @records = pagy_array(@domains, count: @domains.count )
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
    add_breadcrumb "<a class='breadcrumb'>#{@domain.name}</a>".html_safe
  end

  # GET /domains/new
  def new
    add_breadcrumb "<a class='breadcrumb'>New</a>".html_safe
    @domain = Domain.new
  end

  # GET /domains/new
  def image
    add_breadcrumb "<a class='breadcrumb' >Image</a>".html_safe
    response = Connect.new(@domain).mount_url('image', 20, params[:page] || 1)
    if response.code.to_i == 200
      @gallery = JSON.parse(response.read_body, symbolize_names: true)
      @pagy, @records = pagy_array(@gallery, count: response.header[:'x-wp-total'])
    else
      redirect_to request.referer, notice: 'No image found.' 
    end
  end

  def video
    add_breadcrumb "<a class='breadcrumb' >Video</a>".html_safe
    response = Connect.new(@domain).mount_url('video', 20, params[:page] || 1) 
    if response.code.to_i == 200
      @gallery = JSON.parse(response.read_body, symbolize_names: true)
      @pagy, @records = pagy_array(@gallery, count: response.header[:'x-wp-total'])
    else
      redirect_to request.referer, notice: 'No video found.' 
    end
  end

  def audio
    add_breadcrumb "<a class='breadcrumb' >Audio</a>".html_safe
    response = Connect.new(@domain).mount_url('audio', 20, params[:page] || 1)
    if response.code.to_i == 200
      @gallery = JSON.parse(response.read_body, symbolize_names: true)
      @pagy, @records = pagy_array(@gallery, count: response.header[:'x-wp-total'])
    else
      redirect_to request.referer, notice: 'No audio found.' 
    end
  end

  def search
    add_breadcrumb "<a class='breadcrumb' >Search</a>".html_safe
    response = Connect.new(@domain).search(params[:q], 20, params[:page] || 1)
    if response.code.to_i == 200
      @gallery = JSON.parse(response.read_body, symbolize_names: true)
      @pagy, @records = pagy_array(@gallery, count: response.header[:'x-wp-total'])
    else
      redirect_to request.referer, notice: 'No file found.' 
    end
  end
  
  def download_file
    url = params[:url]
    response = HTTParty.get(url)
    if response.code.to_i == 200
      tempfile = Down.download(url) 
      data = open(tempfile.path).read
      send_data data, disposition: 'attachment', filename: tempfile.original_filename
    else
      redirect_to request.referer, notice: 'No download found.' 
    end
  end
  

  # GET /domains/1/edit
  def edit
    add_breadcrumb "<a class='breadcrumb' >Edit</a>".html_safe
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Domain.new(domain_params)

    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render :show, status: :created, location: @domain }
      else
        format.html { render :new }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id] || params[:domain_id])
    end

    def set_breadcrumb
      add_breadcrumb "<a class='breadcrumb' href='#{domain_path(@domain)}'>#{@domain.name}</a>".html_safe
    end

    # Only allow a list of trusted parameters through.
    def domain_params
      params.require(:domain).permit(:name, :protocol, :host)
    end
end
