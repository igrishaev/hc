cjson = require "cjson"

db = {}
db["999"] = {name = "Ivan"}

function create_user (id)
  db[id] = 1000
  return
end

function get_user (id)
  return cjson.encode(db[id])
end
