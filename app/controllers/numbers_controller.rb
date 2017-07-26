class NumbersController < ApplicationController
  LOCALES = [
    ['English', 'en'],
    ['Spanish', 'es'],
    ['Русский', 'ru'],
    ['Français', 'fr'],
    ['Українська', 'ua'],
    ['Magyar', 'hu'],
    ['Lietuvių', 'lt'],
    ['Latviešu', 'lv'],
    ['Eesti', 'et'],
    ['ქართული (Georgian)', 'ka'],
    ['Türkçe', 'tr'],
    ['Deutsch', 'de'],
    ['Italiano', 'it'],
    ['Nederlands', 'nl'],
    ['Swedish', 'se'],
    ['English (British)', 'en-GB'],
    ['Português', 'pt'],
    ['Português Brasileiro', 'pt-BR']
  ]

  def index
    @locales = LOCALES
    @pager = NumberPager.new(params[:count], params[:page])
    @locale = params[:locale].nil? ? 'en-GB' : params[:locale]
  end
end
