class ProductsController < RankingController
  def index
    @products = Product.order('id ASC').limit(20)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    # 検索フォームのキーワードをあいまい検索して、productsテーブルから20件の作品情報を取得する
    # binding.pry
    @products = Product.where('title LIKE(?)', '%params[:keyword]%')
  end
end
