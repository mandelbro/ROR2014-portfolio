module ApplicationHelper

  def title(page_title, options={})
    content_for(:title, page_title.to_s)
  end

  def markdown text
    options = { hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    raw markdown.render(text)
  end

end
