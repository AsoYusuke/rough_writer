class Admin::GenresController < ApplicationController
  # 管理者以外が入れないように制限
  before_action :authenticate_admin!
    
    def index
      @genre = Genre.new
      @genres = Genre.page(params[:page]).per(8)
    end

    def edit
      @genre = Genre.find(params[:id])
    end

    def create
      @genre = Genre.new(genre_params)
      if @genre.save
        redirect_to admin_genres_path(@genre)
      else
        @genres = Genre.page(params[:page]).per(8)
        render :index
      end
    end

    def update
      @genre = Genre.find(params[:id])
      if @genre.update(genre_params)
        redirect_to admin_genres_path(@genre)
      else
        render :edit
      end
    end

    private

    def genre_params
      params.require(:genre).permit(:genre_name)
    end

end
