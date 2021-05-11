class SearchController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "user"
      @records = User.search_for(@content, @method).page(params[:page]).reverse_order
    else
      @records = Post.search_for(@content, @method).page(params[:page]).reverse_order
    end
  end
end
