def fun_event(*actors)
  names = actors.collect(&:to_s).join(", ")
  "#{names} do something fun"
end

def big_conversation(*actors)
  names = actors.collect(&:to_s).join(", ")
  "#{names} have a big conversation"
end

def random_job(actor)
  "#{actor} gets a job"
end
