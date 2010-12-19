=begin
Dir.chdir(File.dirname(__FILE__))
Dir.glob('x*y*a') do |filename|
  new_name = filename.sub('a','')
  File.rename(filename,new_name)
end
=end

=begin
Dir.chdir(File.dirname(__FILE__))
Dir.glob('x*y*') do |filename|
  x, y = filename.match(/x(\d{1,2})y(\d{1,2})/).captures
  File.rename(filename,"x#{x.to_i+1}y#{y.to_i+1}a")
end
=end


require 'fileutils'
Dir.chdir(File.dirname(__FILE__))
(1..11).each do |y|
  dir = "y#{y}"
  Dir.mkdir(dir) unless File.exists?(dir)
  Dir.glob("x*#{dir}") do |sdir|
    puts sdir
    FileUtils.move(sdir, dir)
  end
end


=begin
Dir.chdir(File.dirname(__FILE__))
16.times do |x|
  11.times do |y|
    dir = "x#{x}y#{y}"
    filename = "./#{dir}/terrain.yaml"
    Dir.mkdir(dir) unless File.exists?(dir)
    unless File.exists?(filename)
      File.open(filename,"w") do |file|
        file.write(<<-EOF
--- 
:data: |
    0000000000000000
    0..............0
    0..............0
    0..............0
    0..............0
    0..............0
    0..............0
    0..............0
    0..............0
    0..............0
    0000000000000000    
:mappings: {
    '0': :stone_wall
}
:default: :grass_floor        
EOF
        )
      end
    end
  end
end
=end