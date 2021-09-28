SERVER = IsDuplicityVersion()
CLIENT = not SERVER

local modules = {}

function Module(rsc, path)
  local key = rsc.."/"..path
  local rets = modules[key]
  if rets then -- cached module
    return table.unpack(rets, 2, rets.n)
  else
    local code = LoadResourceFile(rsc, path..".lua")
    if code then
      local f, err = load(code, rsc.."/"..path..".lua")
      if f then
        local rets = table.pack(xpcall(f, debug.traceback))
        if rets[1] then
          modules[key] = rets
          return table.unpack(rets, 2, rets.n)
        else
          error("error loading module "..rsc.."/"..path..": "..rets[2])
        end
      else
        error("error parsing module "..rsc.."/"..path..": "..err)
      end
    else
      error("resource file "..rsc.."/"..path..".lua not found")
    end
  end
end

local function wait(self)
  local r = Citizen.Await(self.p)
  if not r then
    if self.r then
      r = self.r
    else
      error("async wait(): Citizen.Await returned (nil) before the areturn call.")
    end
  end
  return table.unpack(r, 1, r.n)
end

local function areturn(self, ...)
  self.r = table.pack(...)
  self.p:resolve(self.r)
end
  
-- create an async returner or a thread (Citizen.CreateThreadNow)
-- func: if passed, will create a thread, otherwise will return an async returner
function async(func)
  if func then
    Citizen.CreateThreadNow(func)
  else
    return setmetatable({ wait = wait, p = promise.new() }, { __call = areturn })
  end
end

IDGenerator = {}

function newIDGenerator()
  local r = setmetatable({}, { __index = IDGenerator })
  r:construct()
  return r
end

function IDGenerator:construct()
  self:clear()
end

function IDGenerator:clear()
  self.max = 0
  self.ids = {}
end

-- return a new id
function IDGenerator:gen()
  if #self.ids > 0 then
    return table.remove(self.ids)
  else
    local r = self.max
    self.max = self.max+1
    return r
  end
end

-- free a previously generated id
function IDGenerator:free(id)
  table.insert(self.ids,id)
end
