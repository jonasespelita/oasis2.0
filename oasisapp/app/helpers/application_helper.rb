# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def get_follower idno
    followers = Follower.find_all_by_idno idno
    followers.each do |follower|
      if follower.user_id == current_user.id
        return follower
      end
    end
  end
  
    
    
    def coolbox(x,y, title, link, text)
      "<a rel='gb_page_center[#{x}, #{y}]' title='#{title}' href='#{link}'>#{text}</a>"
    end
    
    def number_to_currency_with_cents(number, options = {})
    options = options.stringify_keys
    precision = options.delete('precision') { 2 }
    unit = options.delete('unit') { 'PHP' }
    fractional_unit = options.delete('fractional_unit') { '&cent;' }
    separator = options.delete('separator') { '.' }
    delimiter = options.delete('delimiter') { ',' }
    separator = '' unless precision > 0
    begin
        fraction = number.abs % 1.0
        body = number.floor
        if body != 0 || body == 0 && fraction == 0 then
            parts = number_with_precision(number, precision).split('.')
            unit + number_with_delimiter(parts[0], delimiter) + separator + parts[1].to_s
        else
            (fraction * 100).to_i.to_s + fractional_unit
        end
    rescue
        number
    end
end

end
