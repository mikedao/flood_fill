class Flood
  attr_reader :splitted

  def initialize(input)
    @input = input
  end

  def get_info
    @width      = (@input.split.first.to_i) - 1
    @length     = (@input.split[1].to_i) - 1
    @character  = @input.split.last
    @y          = (@input.split[-2].to_i) - 1
    @x          = (@input.split[-3].to_i) - 1
    @splitted = setup_board(@input.split)

    puts "Width is: #{@width}"
    puts "Length is: #{@length}"
    puts "Fill character is: #{@character}"
    puts "x coordinate: #{@x}"
    puts "y coordinate: #{@y}"
  end

  def setup_board(board)
    board.shift
    board.shift
    board.pop
    board.pop
    board.pop
    board.map { |row| row.chars }
  end

  def fill_first
    @splitted[@y][@x] = @character
  end

  def fill_all_the_things
    @changes = 0
    (0..@width).map do |xpos|
      (0..@length).map do |ypos|
        if @splitted[ypos][xpos] == @character
          if @splitted[ypos+1][xpos] == "."
            @splitted[ypos+1][xpos] = @character
            @changes = @changes + 1
          end
          if @splitted[ypos-1][xpos] == "."
            @splitted[ypos-1][xpos] = @character
            @changes = @changes + 1
          end
          if @splitted[ypos][xpos+1] == "."
            @splitted[ypos][xpos+1] = @character
            @changes = @changes + 1
          end
          if @splitted[ypos][xpos-1] == "."
            @splitted[ypos][xpos-1] = @character
            @changes = @changes + 1
          end
        end
      end
    end
    fill_all_the_things if @changes > 0


  end

  def output
    @splitted.map { |row| row << "\n" }.join
  end
end

string = "37 22
.....................................
...#######################...........
...#.....................#...........
...#.....................#...........
...#.....................#...........
...#.....................#...........
...#.....................#...........
...#.....................#######.....
...###.................##......#.....
...#..##.............##........#.....
...#....##.........##..........#.....
...#......##.....##............#.....
...#........#####..............#.....
...#........#..................#.....
...#.......##..................#.....
...#.....##....................#.....
...#...##......................#.....
...#############################.....
.....................................
.....................................
.....................................
.....................................
8 12 @"
flood = Flood.new(string)
flood.get_info
flood.fill_first
flood.fill_all_the_things
puts flood.output
