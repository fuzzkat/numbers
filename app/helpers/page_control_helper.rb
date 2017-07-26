include ActionView::Helpers::AssetTagHelper

module PageControlHelper
  SPACER = ' &nbsp; '
  FIRST = image_tag('first.svg', size: '16x16')
  LAST  = image_tag('last.svg', size: '16x16')
  PREV  = image_tag('prev.svg', size: '16x16')
  NEXT  = image_tag('next.svg', size: '16x16')

  def page_control pager, locale = nil
    page_control = "" 
    if pager.has_previous
      page_control << link_to(FIRST, numbers_path(count: pager.count, page: 1, locale: locale))
      page_control << SPACER
      page_control << link_to(PREV, numbers_path(count: pager.count, page: pager.page-1, locale: locale))
      page_control << SPACER
    end

    (-3..3).each do |index|
      target_page = pager.page+index
      if pager.has_page(target_page)
        page_control << link_to_if(target_page != pager.page, target_page, numbers_path(count: pager.count, page: target_page, locale: locale))
        page_control << " "
      end
    end

    if pager.has_next
      page_control << SPACER
      page_control << link_to(NEXT, numbers_path(count: pager.count, page: pager.page+1, locale: locale))
      page_control << SPACER
      page_control << link_to(LAST, numbers_path(count: pager.count, page: pager.last_page, locale: locale))
    end
    page_control.html_safe
  end
end
