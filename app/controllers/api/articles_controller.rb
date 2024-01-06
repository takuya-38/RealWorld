module Api
  class ArticlesController < ApplicationController
    include JwtAuthenticator
    before_action :jwt_authenticate, only: %i[create update destroy]
    before_action :set_article, only: %i[show update destroy]

    def show
      if @article
        render json: { article: @article }
      else
        render json: { "errors" => ['not found or invalid credentials'] }, status: :unprocessable_entity
      end
    end

    def create
      article = Article.new(article_params)
      if article.save
        render json: { article: article }
      else
        render json: { "errors" => ['not found or invalid credentials'] }, status: :unprocessable_entity
      end
    end

    def update
      if @article.update(article_params)
        render json: { article: @article }
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      render status: :no_content
    end

    private
      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :description, :body, :tagList)
      end
  end

end
