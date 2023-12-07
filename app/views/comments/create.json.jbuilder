if @new_comment.persisted?
  json.form render(partial: "articles/comments", formats: :html, locals: { article: @article })
end
