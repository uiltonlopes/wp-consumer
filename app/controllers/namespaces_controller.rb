class NamespacesController < ApplicationController
  before_action :set_namespace, only: [:show, :edit, :update, :destroy]

  # GET /namespaces
  # GET /namespaces.json
  def index
    @namespaces = Namespace.all
  end

  # GET /namespaces/1
  # GET /namespaces/1.json
  def show
  end

  # GET /namespaces/new
  def new
    @namespace = Namespace.new
  end

  # GET /namespaces/1/edit
  def edit
  end

  # POST /namespaces
  # POST /namespaces.json
  def create
    @namespace = Namespace.new(namespace_params)

    respond_to do |format|
      if @namespace.save
        format.html { redirect_to @namespace, notice: 'Namespace was successfully created.' }
        format.json { render :show, status: :created, location: @namespace }
      else
        format.html { render :new }
        format.json { render json: @namespace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /namespaces/1
  # PATCH/PUT /namespaces/1.json
  def update
    respond_to do |format|
      if @namespace.update(namespace_params)
        format.html { redirect_to @namespace, notice: 'Namespace was successfully updated.' }
        format.json { render :show, status: :ok, location: @namespace }
      else
        format.html { render :edit }
        format.json { render json: @namespace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /namespaces/1
  # DELETE /namespaces/1.json
  def destroy
    @namespace.destroy
    respond_to do |format|
      format.html { redirect_to namespaces_url, notice: 'Namespace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_namespace
      @namespace = Namespace.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def namespace_params
      params.require(:namespace).permit(:namespace)
    end
end
