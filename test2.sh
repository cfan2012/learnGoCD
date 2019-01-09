#!/bin/bash
set -v off
jmeterFile2='/Users/Bo/PublisherAPI-Brz.jmx'
jmeterFile='/Users/Bo/test2.jmx'
jmeterApp='/usr/local/Cellar/jmeter/5.0/bin/jmeter'
jmeterOut='/Users/Bo/result.jtl'
echo -n "" > $jmeterOut
jmeterCommand=`$jmeterApp -n -t $jmeterFile -l $jmeterOut`
echo $jmeterCommand
name=""
threadName=""
flag=0
while read typeline
do
	typeInf=$typeline
	
	i=1
	while((1==1))
	do
        split=`echo $typeInf|cut -d "," -f$i`
        if [ "$split" != "" ]
        then
                ((i++))
                if [ "$i" -eq "10" ];then
                	if [[ $split =~ " " ]];then
                		echo Test Case \"$name\" from thread \"$threadName\" occurred a error, resaon is \"$split\".
                		flag=1
                	fi
            	fi

            	if [ "$i" -eq "4" ];then
            		name=$split
            	fi

            	if [ "$i" -eq "7" ];then
            		threadName=$split
            	fi

        else
                break
        fi
	done

done < $jmeterOut

exit $flag

