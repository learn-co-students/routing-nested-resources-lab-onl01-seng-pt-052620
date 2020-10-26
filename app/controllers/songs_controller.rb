class SongsController < ApplicationController
  def index
    if params[:artist_id] 
      @songs = Artist.find(params[:author_id]).songs 
    else 
      @songs = Song.all
    end
  end 

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

# 4. Update the `songs_controller` to allow the `songs#index` and `songs#show` actions to handle a valid song for the artist.
# 5. In the `songs#index` action, if the artist can't be found, redirect to the `index` of artists, and set a `flash[:alert]` of "Artist not found."