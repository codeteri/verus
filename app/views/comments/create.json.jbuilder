if @new_comment.persisted?
  json.form render(partial: "articles/article", formats: :html, locals: {article: @article})
end
