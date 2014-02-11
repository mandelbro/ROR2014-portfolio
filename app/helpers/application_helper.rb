module ApplicationHelper

  def title(page_title, options={})
    content_for(:title, page_title.to_s)
  end

end

def markdown text
  options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis]
  Redcarpet.new(text, *options).to_html
end
