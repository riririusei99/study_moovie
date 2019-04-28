class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    domain = "http://review-movie.herokuapp.com"

    # パスの部分を変数で定義(はじめは、空にしておきます)
    next_url = ""

    while true do
      current_page = agent.get(domain + next_url)
      elements = current_page.search('h2 a')
      elements.each do |ele|
        links << domain + ele.get_attribute('href')
      end
      # 「次へ」を表すタグを取得
      next_tag = current_page.at('.pagination .next a')
      # next_linkがなかったらwhile文を抜ける
      if next_tag == nil then
        break
      # そのタグからhref属性の値を取得
      else
        next_url = next_tag.get_attribute('href')
      end
    end
    links.each do |link|
      get_product(link)
    end
  end

  # 個別ページの情報を取得する
  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)

    title = page.at('h2.entry-title').inner_text
    # 画像がない場合はnilを返す
    image_url = page.at('.entry-content img').get_attribute('src') if page.at('.entry-content img') 

    # インスタンス作成・保存
    product = Product.where(title: title, image_url: image_url).first_or_initialize
    product.save
  end
end