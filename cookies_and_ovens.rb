# Answer These Questions:

# - What are essential classes?
# - What attributes will each class have?
# - What interface will each class provide?
# - How will the classes interact with each other?
# - Which classes will inherit from others, if any?


# As a baker, I want to make different types of cookies (peanut butter, chocolate chip, etc.).
# As a baker, I want to place batches of cookies in an oven.
# As a baker, I want to know when a batch of cookies is ready to be removed from the oven.


#MVP PSEUDOCODE

# #One cookie class
#   - baked?
# #One oven class
#    - on/off
#    - temp
#    - cookies inside?
#    - door open?closed?
#    - timer
# #Baker class
#    - baking times
#    -

   #make batch of cookies
   #turn on oven
   #put cookies in oven
   #check cookies
   #take cookies out of oven
   #turn off oven

class Baker
  attr_reader :bakers_dozen, :batch
  attr_accessor :oven, :cookie_sheet, :cookie_jar

  def initialize
    @cookie_sheet = []
    @batch = []
    @oven = nil
    @cookie_jar = []
  end

  def make_cookie_batch(cookie_type)
    13.times {batch << Kernel.const_get(cookie_type).new}
    batch
  end

  def put_cookies_on_sheet
    cookie_sheet << batch
  end

  def turn_on_oven
    has_oven?
    oven.oven_on = true
  end

  def turn_off_oven
    oven.oven_on = false
  end

  def put_cookies_in_oven
    oven.oven_cavity << cookie_sheet
  end

  def check_cookies
    batch_status = nil
    oven.oven_cavity.each do |sheet|
      batch_status = sheet[0][0].cookie_status
    end
    batch_status
  end

  def remove_cookies
    put_cookies_in_jar(oven.oven_cavity.pop)
    self.cookie_sheet = []
    "Yum!  Freshly baked cookies!"
  end

  def put_cookies_in_jar(sheet)
    sheet.each do |batch|
      batch.size.times do
        cookie_jar << batch.pop
      end
    end
  end

  def check_cookie_jar
    puts "Your cookie jar contains:"
    count_cookies.each do |cookie, count|
      puts "#{count} #{cookie}s"
    end
  end

  def count_cookies
    count = {}
    cookie_jar.each do |cookie|
      if count.keys.include? cookie.cookie_type
        count[cookie.cookie_type] += 1
      else
        count[cookie.cookie_type] = 1
      end
    end
    count
  end

  private

  def has_oven?
    self.oven = Oven.new unless oven
  end

end

class Oven
  attr_accessor :oven_cavity, :oven_on

  def initialize
    @oven_on = false
    @oven_cavity = []
  end

  def bake(time)
    oven_cavity.each do |sheet|
      sheet.each do |batch|
        batch.each do |cookie|
          cookie.time_in_oven += time
        end
      end
    end
  end

end

class Cookie
  attr_accessor :time_in_oven
  attr_reader :cookie_type
  PERFECT_COOKING_TIME = 15

  def initialize
    @delicious = true
    @time_in_oven = 0
  end

  def cookie_status
    case time_in_oven - self.class::PERFECT_COOKING_TIME
      when -1000..-4 then :doughy
      when -4..-2 then :almost_ready
      when 0 then :ready
      when 3..5 then :overdone
      when 5..1000 then :burned
    end
  end
end

class Snickerdoodle < Cookie
  PERFECT_COOKING_TIME = 10
  def initialize
    super
    @cookie_type = "Snickerdoodle"
  end
end

class MandMCookie < Cookie
  PERFECT_COOKING_TIME = 15
  def initialize
    super
    @cookie_type = "M & M Cookie"
  end
end

class RussianTeaCake < Cookie
  PERFECT_COOKING_TIME = 12
  def initialize
    super
    @cookie_type = "Russian Tea Cake"
  end
end


# betty_the_baker = Baker.new


# p betty_the_baker.turn_on_oven
# betty_the_baker.make_cookie_batch(:Snickerdoodle)
# betty_the_baker.put_cookies_on_sheet
# betty_the_baker.put_cookies_in_oven
# betty_the_baker.oven.bake(4)
# p betty_the_baker.check_cookies
# betty_the_baker.oven.bake(6)
# p betty_the_baker.check_cookies
# p betty_the_baker.remove_cookies
# betty_the_baker.make_cookie_batch(:RussianTeaCake)
# betty_the_baker.put_cookies_on_sheet
# betty_the_baker.put_cookies_in_oven
# betty_the_baker.oven.bake(3)
# p betty_the_baker.check_cookies
# betty_the_baker.oven.bake(1)
# p betty_the_baker.check_cookies
# p betty_the_baker.remove_cookies
# betty_the_baker.make_cookie_batch(:MandMCookie)
# betty_the_baker.put_cookies_on_sheet
# betty_the_baker.put_cookies_in_oven
# betty_the_baker.oven.bake(13)
# p betty_the_baker.check_cookies
# betty_the_baker.oven.bake(29)
# p betty_the_baker.check_cookies
# p betty_the_baker.remove_cookies
# betty_the_baker.check_cookie_jar



# additional things to consider:

# do we want multiple batches on a sheet?
# make cookie jar class
# make sheet class with maximum cookie load attribute
# oven capacity--how many sheets can it hold?




