BLOCKNOTIFYURL=https://v7f30u8t0d.execute-api.us-east-1.amazonaws.com/v0/blocknotify
CHAIN=$1
height=1
size=1999029
source start

now=$(( $(date +%s) -$(( $RANDOM % 60 + 1 )) ))
sleep $(( $start -$now ))

while true
do
  time=$(( $(date +%s ) - $(( ( RANDOM % 110 )  + 10 )) ))
  ttl=$(( $(date +%s) +900 ))
  curl \
  --silent \
  --request OPTIONS \
  ${BLOCKNOTIFYURL} \
  --header 'Origin: http://localhost:8000' \
  --header 'Access-Control-Request-Headers: Origin, Accept, Content-Type' \
  --header 'Access-Control-Request-Method: POST'
  sleep 1
  resultJSON=$(curl \
  --silent \
  --header "Origin: http://localhost:8000" \
  --request POST \
  -d "{ \"size\": ${size}, \"height\": ${height}, \"time\": ${time}, \"tx\": 8859, \"ac\": \"${CHAIN}\", \"ttl\": ${ttl} }" \
  ${BLOCKNOTIFYURL} )
  echo $resultJSON
  if [[ $height -eq 120 ]]; then
    exit
  fi
  height=$(( $height +1 ))
  sleep $(( ( RANDOM % 60 )  + 30 ))
done
