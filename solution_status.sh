#!/bin/bash
usage() {
    echo "usage: $(basename $0) --sd <solution definition file name> "
    echo "    where:"
    exit 1;
}

while [ ! -z $2 ]; do
    case "$1" in
        --sd ) input=$2 ;;
        * ) usage ;;
    esac

    shift
done
echo "input file="$input

if [ -z $input ]; then
    usage
fi

install_service(){
	service_name=$1
	bd_ip=$3
       	server=root@$bd_ip
        
        echo "*** Service $service_name status: ***"
#	ssh $server "$service_name/status.sh" < /dev/null
        ssh $server "bash -s" < $service_name/status.sh 
}

while IFS=',' read -r f1 f2 f3 f4 f5 f6 f7
do 
  ## Ignore lines start with "#"
  case $f1 in
        \#*) continue;;
  esac
  echo "************************************** "
install_service $f1 $f2 $f3 $f4 $f5 $f6 $f7 
done < "$input"

