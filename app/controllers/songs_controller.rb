class SongsController < ApplicationController
  before_filter :lookup_artist
  before_filter :lookup_song

  def index
    # @songs = Song.all
    @songs = @artist && @artist.songs || Song.all
  end

  def show
    # @song = Song.find(params[:id])
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

  def lookup_artist
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if !@artist
        flash[:alert] = "Artist not found"
        redirect_to artists_path
      end
    end
  end

  def lookup_song
    if params[:id]
      if @artist
        @song = @artist.songs.find_by(id: params[:id])
        if !@song
          flash[:alert] = "Song not found"
          redirect_to(artist_songs_path(@artist))
        end
      else
        @song = Song.find(params[:id])
      end
    end
  end

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end