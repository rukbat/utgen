-- vars
secondsToSleep = 1
local filename = 'maps-DM.txt'

-- Sleep
function sleep(s)
  local ntime = os.time() + s
  repeat until os.time() > ntime
end

-- http://lua-users.org/wiki/FileInputOutput

-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- Load from file
local lines = lines_from(filename)

-- Shuffle entries
math.randomseed( os.time() )
for i = 1, #lines*2 do -- repeat this for twice the amount of elements in the table, to make sure everything is shuffled well
  local a = math.random(#lines)
  local b = math.random(#lines)
  lines[a],lines[b] = lines[b],lines[a]
end

-- I/O
print("Enter number of matches in the season:")
nChampionshipMatches = io.read("*number")
print("Enter number of matches in the finals:")
nFinalMatches = io.read("*number")

-- Simple check
if (nChampionshipMatches + nFinalMatches > #lines) then
  print("Too much matches entered")
  os.exit(1)
end

-- Print championship maps
print('Championship maps:')
for i=1,nChampionshipMatches do
  sleep(secondsToSleep)
  print(i .. ') ', lines[i])
end

-- Print finals maps
print('Finals maps:')
for i=nChampionshipMatches+1,nChampionshipMatches+nFinalMatches do
  sleep(secondsToSleep)
  print(i .. ') ', lines[i])
end