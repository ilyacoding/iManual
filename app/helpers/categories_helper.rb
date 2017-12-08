module CategoriesHelper
  def translation_by_slug(slug, locale = nil)
    translation_key = "activerecord.models.category_slug.#{slug}"
    locale.blank? ? t(translation_key) : t(translation_key, locale: locale)
  end
end
