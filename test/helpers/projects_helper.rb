
def fill_in_project_form(params = {})

  params = {
    company: 'test',
    body: "test test",
    technologies: 'all the techs',
    lead_image: 'test/files/upco-leadimg.jpg',
    other_images: 'testimage.jpg',
    quote: 'Test Quote',
    quote_attr: 'Test Person',
    weight: 1,
  }.merge(params)

  page.find('#project-form').fill_in "Company", with: params[:company]
  page.find('#project-form').fill_in "Body", with: params[:body]
  page.find('#project-form').fill_in "Technologies", with: params[:technologies]
  page.find('#project-form').attach_file 'Lead Image', params[:lead_image]
  page.find('#project-form').fill_in "Other Images", with: params[:other_images]
  page.find('#project-form').fill_in "Quote", with: params[:quote]
  page.find('#project-form').fill_in "Quote Attribution", with: params[:quote_attr]
  page.find('#project-form').fill_in "Weight", with: params[:weight]
end
