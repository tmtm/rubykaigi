Haml::Template.options.update(
  :format      => :xhtml,
  :escape_html => true
)

Sass::Plugin.options.update(
  :template_location => {
    Rails.root.join('public/stylesheets/sass')      => Rails.root.join('public/stylesheets'),
    Rails.root.join('public/2010/stylesheets/sass') => Rails.root.join('public/2010/stylesheets'),
    Rails.root.join('public/2011/stylesheets/sass') => Rails.root.join('public/2011/stylesheets')
  }
)
