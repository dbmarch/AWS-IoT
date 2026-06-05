#  Adjecsted for AWS CLI Version 2, Stephen Borsay
#  Original code found at: https://aws.amazon.com/blogs/iot/integrating-iot-data-with-your-data-lake-with-new-aws-iot-analytics-features/
#  Changes: changed iterations to 3, refined random algorithm, eliminated superflous variables.

mqtttopic='iota'
iterations=10
wait=3
region='us-east-1'
profile='default'

for (( i = 1; i <=$iterations; i++)) {

    #Added these randomizers because old ones didn’t generate good numbers    
    #Temperature in Fehr
    minT=-20
    maxT=120
    numberT=$(expr $minT + $RANDOM % $maxT)

    #humidity % cannot exceed 100
    minH=0
    maxH=100
    numberH=$(expr $minH + $RANDOM % $maxH)

  temperature=$(($numberT ))
  humidity=$(($numberH ))

  echo "Publishing message $i/$ITERATIONS to IoT topic $mqtttopic:"
  echo "temperature: $temperature"
  echo "humidity: $humidity"
  
 #use below for AWS CLI V2
 aws iot-data publish --topic "$mqtttopic" --cli-binary-format raw-in-base64-out --payload "{\"temperature\":$temperature,\"humidity\":$humidity}" --profile "$profile" --region "$region"

  sleep $wait
}
