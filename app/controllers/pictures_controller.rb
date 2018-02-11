class PicturesController < ApplicationController
  before_action :find_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all.order("created_at DESC")

    # Start of destination scrape
destUrl = "http://www.10best.com/destinations/all/"

destResponse = HTTParty.get(destUrl)
# p response.headers['Content-Type']

#String => Nokgiri::HTML => DocumentObjectModel (DOM)
destDom = Nokogiri::HTML(destResponse.body)
# p dom.css('html') #gives everything wthin the html tag

destinations = destDom.css('a.rss')

@cities = []
destinations.each do |city|
  @cities << city.text
end

@links = []
destinations.each do |link|
  @links << 'http://www.10best.com' + link['href']
end
# End of destination scrape

# Start of attractions scrape
attrUrl = "http://www.10best.com/destinations/new-mexico/albuquerque/attractions/best-attractions-activities/"
attrResponse = HTTParty.get(attrUrl)

#String => Nokgiri::HTML => DocumentObjectModel (DOM)
attrDom = Nokogiri::HTML(attrResponse.body)
# p dom.css('html') #gives everything wthin the html tag

attractions = attrDom.css('.list-headline h2')

@venue = []
attractions.each do |place|
  @venue << place.text
end

# Get two random attractions and give them their own variables
@venues = @venue.sample(2)
@venue_one = @venues[0]
@venue_two = @venues[1]

# Index of random photo to grab correct picture
@index_one = @venue.index(@venue_one)
@index_two = @venue.index(@venue_two)

images = attrDom.css('img.lazy')

@image = []
images.each do |picture|
  @image << 'https:' + picture['data-src']
end

# Select image link based on index of random photo
@image_one = @image[@index_one]
@image_two = @image[@index_two]
# End of attractions scrape

  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
  @picture = current_user.pictures.build
  @locations = Location.all.map{ |c| [l.name, l.id]}
end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
@picture = current_user.pictures.build(picture_params)
@picture.location_id = params[:location_id]

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:title, :url, :pic_img)
    end
  end
