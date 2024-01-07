module Api
  class ArticlesController < ApplicationController
    include JwtAuthenticator
    before_action :jwt_authenticate, only: %i[create update destroy]
    before_action :set_article, only: %i[show update destroy]

    def show
      if @article
        render_article(@article)
      else
        render json: { "errors" => ['not found or invalid credentials'] }, status: :unprocessable_entity
      end
    end

    def create
      article = Article.new(article_params)
      if article.save
        render_article(article)
      else
        render json: { "errors" => ['not found or invalid credentials'] }, status: :unprocessable_entity
      end
    end

    def update
      if @article.update(article_params)
        render_article(@article)
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

      def render_article(article)
        render json: { article: {
          slug: article.id,
          title: article.title,
          description: article.description,
          body: article.body,
          tagList: get_tagList(article.id),
          author: article.author,
          createdAt: article.created_at,
          updatedAt: article.updated_at
        } }
      end

      def get_tagList(article_id)
        tagList ||= Tag.where(articles_id: article_id).map(&:name)
        tagList.present? ? tagList : []
      end
  end
end
