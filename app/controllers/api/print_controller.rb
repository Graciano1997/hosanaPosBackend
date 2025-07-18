# require "pos-printer"
# class Api::PrintController < ApplicationController

def index
  ls `lpr -o raw linux.dat`
  # POS::Printer.print("usb://Star/TSP143%20(STR_T-001)") do |p|
  #   p.align_center
  #   p.print_logo
  #   p.big_font
  #   p.text "MY HEADER"
  #   p.align_left
  #   p.small_font
  #   p.text "some body"
  # end
end

index
# end
