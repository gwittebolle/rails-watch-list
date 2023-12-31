class ListsController < ApplicationController

  before_action :set_list, only: [:show]

  def index
    @lists = List.all
  end

  def show;
    @bookmarks = Bookmark.all.where('list_id = ?', params[:id].to_i)
  end

  def new
    @list = List.new()
  end

  def create
    @list = List.new(list_params)
    @list.save
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  # end

  # def update
  # end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end

end
