class FavoritesController < ApplicationController

  def create
    favo = Favorite.new
    favo.user_id=current_user.id
    favo.book_id=params[:book_id]
    # binding.pry
    favo.save
    redirect_to request.referer
  end

  def destroy
    favos = current_user.favorites
    # binding.pry
    favo = favos.find_by(book_id: params[:book_id])
    # binding.pry
    favo.destroy
    redirect_to request.referer
  end
end
