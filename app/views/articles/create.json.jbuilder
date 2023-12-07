if @article.persisted?
  json.inserted_item render(partial: "articles/article", formats: :html, locals: {article: @article})
end


