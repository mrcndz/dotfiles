set shell := ["fish", "-c"]

kill port:
  kill -9 $(lsof -i :{{port}} | awk 'NR > 1 {print $2}') | xargs kill -9
