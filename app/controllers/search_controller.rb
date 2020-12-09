class SearchController < ApplicationController
   before_action :authenticate_user!

    def search
        # binding.pry
        @model = params[:model]
        @content = params[:content]
        @method = params[:method]

        if @model == 'user'
            @records = User.search_for(@content, @method)
            # binding.pry
        else
            @records = Book.search_for(@content, @method)
        end
    end
end
