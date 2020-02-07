class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G', 'PG', 'PG-13', 'R'] #creates list with all the ratings to pick from
    @sort = params[:sort] #gets the sort parameter title/release_date from url
    @selected_ratings = params[:ratings] || Hash[@all_ratings.map {|x| [x, true]}]
    @all_ratings = Hash[@all_ratings.map {|x| [x, @selected_ratings.key?(x)]}]
    session[:sort] = @sort
    session[:ratings] = @selected_ratings
    if !params[:sort] && !params[:ratings] #remembers the session if the action is not sorting/rating
      flash.keep
      redirect_to movies_path(:ratings => @selected_ratings, :sort => @sort) and return
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
